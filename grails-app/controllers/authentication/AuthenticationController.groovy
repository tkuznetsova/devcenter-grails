package authentication

import grails.util.GrailsUtil
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.dao.DataIntegrityViolationException

import authentication.LoginForm
import authentication.SignupForm
import eshop.*

class AuthenticationController {

	def defaultAction = "index"
	
	def authenticationService
	
	def user
	
    /**
     * Extract success_* and error_* into maps that can be passed to redirect(),
     * but forbidding the use of "url" which could lead to XSS attacks or phishing
     */
    def extractParams() {
        def redirectParams = [success:[:], error:[:]]
        params.keySet().each() { name -> 
            if (name.startsWith("success_") || name.startsWith('error_')) {
                def underscore = name.indexOf('_')
                if (underscore >= name.size()-1) return
                def prefix = name[0..underscore-1]
                def urlParam = name[underscore+1..-1]
                if (urlParam != 'url') {
                    redirectParams[prefix][urlParam] = params[name]
                }
            }
        }
        return redirectParams
    }
	
	def login_form = {
//		// Display a page offering the appropriate options by default, but only in development!
//		if (GrailsUtil.environment != GrailsApplication.ENV_DEVELOPMENT) {
//			response.sendError(404)
//		}
		//redirect(controller: "good", action: "list", params: params)
	}

	def login = { LoginForm form ->
	    def urls = extractParams()
		def dummyEvent = new DummyEventHandler()
		if (!form.hasErrors()) {
			def loginResult = authenticationService.login( form.login, form.password)
			
			// TODO: DONE suppress redirect(LinkedHashMap) errors on "No such user" and "Password is incorrect" 
			def userInstance = AuthenticationUser.findByLogin(form.login)
			if(!userInstance) {
				flash.message = message(code: 'default.not.registered.message')
				redirect(controller: "main", action: "index")
			} else {
				if(userInstance.password != authenticationService.encodePassword(form.password)) {
					flash.message = message(code: 'default.bad.password.message')
					redirect(action: "login_form")
				} else {
					if (loginResult.result == 0) {
						flash.loginForm = form
						if (log.debugEnabled) log.debug("Login succeeded for [${form.login}]")
						if(params.login) {
							user = AuthenticationUser.find{params.login}
							if(user){
								session.user = user
							}
						}
						redirect(flash.authSuccessURL ? flash.authSuccessURL : urls.success)
						
						
					} else {                  
						flash.loginForm = form
						flash.authenticationFailure = loginResult
						if (log.debugEnabled) log.debug("Login failed for [${form.login}] - reason: ${loginResult.result}")
						redirect(flash.authFailureURL ? flash.authFailureURL : urls.error)
					}
				}
			}
			
		} else {
			flash.loginForm = form
			flash.loginFormErrors = form.errors // Workaround for grails bug 
			if (log.debugEnabled) log.debug("Login failed for [${form.login}] - form invalid: ${form.errors}")
			redirect(flash.authErrorURL ? flash.authErrorURL : urls.error)
		}
	}

	def signup = { SignupForm form ->
	    def urls = extractParams()
		
		if (!form.hasErrors()) {
			def signupResult = authenticationService.signup( login:form.login, 
				password:form.password, email:form.email, 
				name:form.name,
				creditcardID:form.creditcardID,
				phone:form.phone,
				addressline1:form.addressline1,
				addressline2:form.addressline2,
				city:form.city,
				stateregion:form.stateregion,
				postalcode:form.postalcode,
				country:form.country,
				creditlimit:form.creditlimit,
				role:form.role,
				immediate:true, extraParams:params)
			if ((signupResult.result == 0) || (signupResult.result == AuthenticatedUser.AWAITING_CONFIRMATION)) {
				if (log.debugEnabled) {
					if (signupResult == AuthenticatedUser.AWAITING_CONFIRMATION) {
						log.debug("Signup succeeded pending email confirmation for [${form.login}] / [${form.email}]")
					} else {
						log.debug("Signup succeeded for [${form.login}]")
					}
				}
				// Basket insertion
				if(params.login) {
					user = AuthenticationUser.findByLogin(params.login)
					if(user){
						session.user = user
						def basketInstance = new BasketController().create(session.user.id)
						println " AuthenticationController-signup says ${basketInstance.id}"
						def basketInstance_ = new BasketController().findBasket(basketInstance.id)
						if(basketInstance_) {
							user.basketId = basketInstance_.id
							
							println " AuthenticationController-signup says_ ${basketInstance_.id}"
						}else {
							println "${session.user.login} AuthenticationController-signup says basketInstance uncreated"
						}
						//redirect(controller:"basket", action:"create", params: [userLogin: "${session.user.login}", success_url: "${urls.success}"])
					}
				}
				redirect(flash.authSuccessURL ? flash.authSuccessURL : urls.success)
			} else {
				flash.authenticationFailure = signupResult
				flash.signupForm = form
				if (log.debugEnabled) log.debug("Signup failed for [${form.login}] reason ${signupResult.result}")
				redirect(flash.authErrorURL ? flash.authErrorURL : urls.error)
			}
		} else {
			flash.signupForm = form
			flash.signupFormErrors = form.errors // Workaround for grails bug in 0.5.6
			if (log.debugEnabled) log.debug("Signup failed for [${form.login}] - form invalid: ${form.errors}")
			redirect(flash.authErrorURL ? flash.authErrorURL : urls.error)
		}		
	}

	def logout = { 
	    def urls = extractParams() 
		authenticationService.logout( authenticationService.sessionUser )
		if(params.login) {
			session.user = null
		}
		redirect(flash.authSuccessURL ? flash.authSuccessURL : urls.success)
	}
	
	def findUser(id) {
		def userInstance = new AuthenticationUser().get(session?.user?.id)
		return userInstance
	}
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
println session?.user?.login
		[userInstanceList: AuthenticationUser.findByLogin(session?.user?.login), userInstanceTotal: 1]
	   // [userInstanceList: User.list(params), userInstanceTotal: User.count()]
	}

	def create() {
		[userInstance: new AuthenticationUser(params)]
	}

	def save() {
		params.authentication = AuthenticationUser.findByLogin(session?.user?.login)
		def userInstance = new AuthenticationUser(params)
	
		if (!userInstance.save(flush: true)) {
			render(view: "create", model: [userInstance: userInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
		redirect(action: "show", id: userInstance.id)
	}

	def show(Long id) {
		def userInstance = AuthenticationUser.get(id)
		if (!userInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "list")
			return
		}

		[userInstance: userInstance]
	}

	def edit(Long id) {
		def userInstance = AuthenticationUser.get(id)
		if (!userInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "list")
			return
		}

		[userInstance: userInstance]
	}

	def update(Long id, Long version) {
		def userInstance = AuthenticationUser.get(id)
		if (!userInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (userInstance.version > version) {
				userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'user.label', default: 'User')] as Object[],
						  "Another user has updated this User while you were editing")
				render(view: "edit", model: [userInstance: userInstance])
				return
			}
		}

		userInstance.properties = params

		if (!userInstance.save(flush: true)) {
			render(view: "edit", model: [userInstance: userInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
		redirect(action: "show", id: userInstance.id)
	}

	def delete(Long id) {
		def userInstance = AuthenticationUser.get(id)
		if (!userInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "list")
			return
		}

		try {
			userInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "show", id: id)
		}
	}
}

