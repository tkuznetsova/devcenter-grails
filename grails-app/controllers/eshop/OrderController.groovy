package eshop

import java.util.Date;

import org.springframework.dao.DataIntegrityViolationException

class OrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
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
	
	def create = {
		// create domain object
		def o = new Order(
			status:'0', 
			orderDate: new Date(), 
			requiredDate: new Date() + 30, 
			paymentAmount: Basket.findById(session.user.id).basketCost,
			shippedDate: null,
			user:'${session.user}'
		)
		session.order = o
		o.save()
		if(o.save()) {
			println "Order $o created!"
		} else {
			println "Order $o not created!"
		}

		redirect(controller:'main')
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

}
