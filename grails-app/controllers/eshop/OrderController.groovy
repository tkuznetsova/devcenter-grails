package eshop

import authentication.AuthenticationController
import org.springframework.dao.DataIntegrityViolationException

class OrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
	
	def create(params) {
		println "${params.payment}"
		
		def orderInstance = new Order(status:'0')
		
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
			[orderInstance: orderInstance]
		}else {
			println "${session.user.login} OrderController-create says orderInstance unsaved"
		}
	
	}
	
	def findOrder(id) {
		def orderInstance = new Order().find {id}
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
	
	

}
