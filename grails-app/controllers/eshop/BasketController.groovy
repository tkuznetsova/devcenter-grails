package eshop

import org.springframework.dao.DataIntegrityViolationException
import authentication.*

class BasketController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

	def create() {
		// create domain object
		def basketInstance = new Basket(params)
	println params
		def user = AuthenticationUser.findByLogin(params.userLogin)
		params.user = user
		params.userId = user.id
		params.basketCost=0.0
		params.itemCount=0
	println params
		basketInstance.properties = params
		basketInstance.version = 1
	println basketInstance.properties
		if(basketInstance.save(flush: true)) {
			println "Basket $basketInstance created!"
		} else {
			println "Basket $basketInstance not created!"
		}
		return
		//redirect(controller:"main", action:"index")
	}
	
	def save() {
		def basketInstance = new Basket(params)
		if (!basketInstance.save(flush: true)) {
			render(view: "create", model: [basketInstance: basketInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'basket.label', default: 'Basket'), basketInstance.id])
		redirect(action: "show", id: basketInstance.id)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[basketInstanceList: Basket.list(params), basketInstanceTotal: Basket.count()]
	}
	
	def show(Long id) {
		println params
		Basket basketInstance = Basket.get(params.id)
		//println basketInstance?.user?.login
		if (!basketInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'basket.label', default: 'Basket'), id])
			redirect(action: "list")
			return
		}
		return [basketInstance: basketInstance ]
	}

	def edit(Long id) {
		println params
		Basket basketInstance = Basket.get(params.id)
		
		if (!basketInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'basket.label', default: 'Basket'), id])
			redirect(action: "list")
			return
		}
		return [Basket : basketInstance ]
	}

	def update(Long id, Long version) {
		println params
		Basket basketInstance = Basket.get(params.id)
		basketInstance.properties = params
		basketInstance.save()
		redirect(action:'list')
		if (!basketInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'basket.label', default: 'Basket'), id])
			redirect(action: "list")
			return
		}
		if (version != null) {
			if (basketInstance.version > version) {
				basketIstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'basket.label', default: 'Basket')] as Object[],
						  "Another user has updated this Basket while you were editing")
				render(view: "edit", model: [basketInstance: basketInstance])
				return
			}
		}

		basketInstance.properties = params

		if (!basketInstance.save(flush: true)) {
			render(view: "edit", model: [basketItemInstance: basketInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'basket.label', default: 'Basket'), basketInstance.id])
		redirect(action: "show", id: basketInstance.id)
	}

     def delete(Long id) {
		println params
        def basketInstance = Basket.get(id)
        if (!basketInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'basket.label', default: 'Basket'), id])
            redirect(action: "list")
            return
        }

        try {
            basketInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'basket.label', default: 'Basket'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'basket.label', default: 'Basket'), id])
            redirect(action: "show", id: id)
        }
    }
	
	 def addPurchase(Long id) {
		println params
		BasketItem p = BasketItem.get(id)
		def b = Basket.get(session.user.id).addToPurchase(p).save()

		b.itemCount += 1
		b.basketCost += p.cost

		session.basket = b	
		if (p.save()) {
		println "Purchase added to the basket"
		redirect(controller:"basket", action:"show", id:"${session.user.id}")
		}
		else {
		println "Purchase NOT added to the basket"
		redirect(controller:"basket", action:"show", id:"${session.user.id}")
		}
	}
	
	def removePurchase(Long id) {
		println params
		def p = BasketItem.get(id)			
		Basket b = Basket.get(session.user.id)

		b.itemCount -= p.quantity
		b.basketCost -= p.cost
		if (b.basketCost < 0)
			b.basketCost = 0
		if (b.itemCount < 0)
			b.itemCount = 0
			
		b.removeFromPurchase(p).save()		
		p.delete()
		session.basket = b
		if (p.save()) {
			redirect(controller:"basket", action:"show", id:"${session.user.id}")
		}
		else {
		redirect(controller:"basket", action:"show", id:"${session.user.id}")
		}
	}

}
