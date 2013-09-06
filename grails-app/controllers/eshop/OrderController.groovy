package eshop

import authentication.*
import org.springframework.dao.DataIntegrityViolationException

class OrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
	
	def create(params) {
		println "${params.payment}"
		
		def orderInstance = new Order(status:'0', shippedDate: null)
		
		def basketInstance = new BasketController().findBasket(session.user.basketId)
		if(basketInstance) {
			orderInstance.paymentAmount = basketInstance.basketCost
		} else {
			println "${session.user.login} OrderController-create says BASKET not found"
		}
				
		def userInstance = new AuthenticationController().findUser(session.user.id)
		if(userInstance) {
			orderInstance.authentication = userInstance
		} else {
			println "${session.user.login} OrderController-create says USER not found"
		}
		if(orderInstance.save(flush: true)) {

		}else {
			println "${session.user.login} OrderController-create says orderInstance unsaved"
		}
	
	}
	
	def findOrder(id, byAuthentication) {
		def orderInstance
		if(byAuthentication) {
			def userInstance = new AuthenticationController().findUser(id)
			orderInstance = Order.findByAuthentication(userInstance)
		}else{
			orderInstance = new Order().get(id)
		}
		return orderInstance
	}

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [orderInstanceList: Order.list(params), orderInstanceTotal: Order.count()]
    }

    def show(Long id) {
        def orderInstance = Order.get(id)
        if (!orderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'order.label', default: 'Order'), id])
            redirect(action: "list")
            return
        }

        [orderInstance: orderInstance]
    }
	
	def edit(Long id) {
		def orderInstance = Order.get(id)
		if (!orderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'order.label', default: 'Order'), id])
			redirect(action: "list")
			return
		}

		[orderInstance: orderInstance]
	}

	def update(Long id, Long version) {
		def orderInstance = Order.get(id)
		if (!orderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'order.label', default: 'Order'), id])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (orderInstance.version > version) {
				orderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'order.label', default: 'Order')] as Object[],
						  "Another user has updated this Order while you were editing")
				render(view: "edit", model: [orderInstance: orderInstance])
				return
			}
		}

		orderInstance.properties = params

		if (!orderInstance.save(flush: true)) {
			render(view: "edit", model: [orderInstance: orderInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'order.label', default: 'Order'), orderInstance.id])
		redirect(action: "show", id: orderInstance.id)
	}

	def delete(Long id) {
		def orderInstance = Order.get(id)
		if (!orderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'order.label', default: 'Order'), id])
			redirect(action: "list")
			return
		}

		try {
			orderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'order.label', default: 'Order'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'order.label', default: 'Order'), id])
			redirect(action: "show", id: id)
		}
	}

}
