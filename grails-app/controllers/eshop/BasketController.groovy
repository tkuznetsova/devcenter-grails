package eshop

import authentication.AuthenticationController
import org.springframework.dao.DataIntegrityViolationException

class BasketController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {	
        redirect(action: "show", params: params)
    }

	def create(id) {
		def basketInstance = new Basket(params)
		params.basketCost=0.0
		params.itemCount=0
		basketInstance.properties = params
		basketInstance.version = 1	
		
		def userInstance = new AuthenticationController().findUser(id)
		basketInstance.user = userInstance
		println "${session.user.login} AuthenticationController-signup says user not found"
		if(basketInstance.save()) {
		
		}else {
			println "${session.user.login} AuthenticationController-signup-Basket-create says basketInstance unsaved"
		}
		return basketInstance
	}
	
	def findBasket(id) {
		def basketInstance = new Basket().get(id)
		return basketInstance 
	}
	
	def order() {		
		def basketInstance = Basket.get(session.user.basketId)
		if(basketInstance) {
			def orderInstance = new OrderController().create(params: [payment: "${basketInstance.basketCost}"])
			if(!orderInstance) {
				println "A - OrderControlle-order says: order creation fails"
			}else{	
				def order = new OrderController().findOrder(orderInstance.id)
				if (order) {
					def basketItemIsSaved = new BasketItemController().setOrder(basketInstance.id, order.id)
					if(basketItemIsSaved) {
						redirect(controller: "order", action: "show")
					}else{
						println "C - OrderControlle-order says: order setting fails"
					}
				}else {
					println "D - OrderControlle-order says: order is not found"
				}
			}
		}else {
			println "B - OrderControlle-order says: basket is not got"
		}
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
	
	def show(Long id) {
		println params
		Basket basketInstance = Basket.get(id)
		
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
	
	def addToBasket(Long id) {
		def basketInstance = Basket.get(session.user.basketId)
		def purchase = new BasketItemController().findBasketItem(id)		
		
		basketInstance.itemCount += purchase.quantity
		basketInstance.basketCost += purchase.cost
		
		println "Count 1: ${basketInstance.count()}"
		println "Count 2: ${basketInstance.itemCount}"
		
		if (purchase.save(flush: true)) {
		println "Purchase is added to the basket"
		redirect(controller:"basket", action:"show", id:"${session.user.basketId}")
		}
		else {
		println "Purchase NOT added to the basket"
		redirect(controller:"basket", action:"show", id:"${session.user.basketId}")
		}
	}
		
	def removePurchase(Long id) { // fromBasket
		println params
		def p = BasketItem.get( id )
		//println "${p.good.name}"
			
			Basket b = Basket.get(session.user.id)
println b.basketCost
println b.itemCount
			// Delete one entire nomenclature
			b.itemCount -= p.quantity
println p.quantity
println p.cost

			// Delete the price of product
			b.basketCost -= p.cost
println b.basketCost

			
			// The price cannot be less than 0
		if (b.basketCost < 0)
			b.basketCost = 0
		if (b.itemCount < 0)
			b.itemCount = 0
			
		b.removeFromPurchase(p)
		.save()
		
		p.delete()
		session.basket = b
		println "Count 1: ${b.count()}"
		println "Count 2: ${b.itemCount}"
println b.basketCost
			if (p.save()) {
			redirect(controller:"basket", action:"show", id:"${session.user.id}")
		}
		else {
		redirect(controller:"basket", action:"show", id:"${session.user.id}")
		}
	}
}
