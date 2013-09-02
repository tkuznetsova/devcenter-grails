package eshop

import authentication.AuthenticationController
import org.springframework.dao.DataIntegrityViolationException

class BasketItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	//def user = session["user"]
	
	def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [basketItemInstanceList: BasketItem.list(params), basketItemInstanceTotal: BasketItem.count()]
    }

    def create() {
        [basketItemInstance: new BasketItem(params)]
    }
	
	

    def save() {
        def basketItemInstance = new BasketItem(params)
        if (!basketItemInstance.save(flush: true)) {
            render(view: "create", model: [basketItemInstance: basketItemInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), basketItemInstance.id])
        redirect(action: "show", id: basketItemInstance.id)
    }

    def show(Long id) {
        def basketItemInstance = BasketItem.get(id)
        if (!basketItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), id])
            redirect(action: "list")
            return
        }

        [basketItemInstance: basketItemInstance]
    }

    def edit(Long id) {
        def basketItemInstance = BasketItem.get(id)
        if (!basketItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), id])
            redirect(action: "list")
            return
        }

        [basketItemInstance: basketItemInstance]
    }

    def update(Long id, Long version) {
        def basketItemInstance = BasketItem.get(id)
        if (!basketItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (basketItemInstance.version > version) {
                basketItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'basketItem.label', default: 'BasketItem')] as Object[],
                          "Another user has updated this BasketItem while you were editing")
                render(view: "edit", model: [basketItemInstance: basketItemInstance])
                return
            }
        }

        basketItemInstance.properties = params

        if (!basketItemInstance.save(flush: true)) {
            render(view: "edit", model: [basketItemInstance: basketItemInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), basketItemInstance.id])
        redirect(action: "show", id: basketItemInstance.id)
    }

    def delete(Long id) {
        def basketItemInstance = BasketItem.get(id)
        if (!basketItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), id])
            redirect(action: "list")
            return
        }

        try {
            basketItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'basketItem.label', default: 'BasketItem'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def addPurchase (Long id) {
		def basketItemInstance = new BasketItem(quantity:'1')
		if(basketItemInstance) {
			println "BaskItemController-addToBasket says basketItemInstance is created for ${session.user.login}: ${session.user}"
		}
		// create domain objects and assign parameters using data binding
		def product = new GoodController().findGood( id )
		if(product) {
			println "${product.name}"
			basketItemInstance.good = product
			basketItemInstance.cost = product.price
		}
		def userInstance = new AuthenticationController().findUser(session?.user?.id)
		if(userInstance) {
			basketItemInstance.user = userInstance
		}
		def basketInstance = new BasketController().findBasket( session?.user?.basketId )
		if(basketInstance) {
			basketItemInstance.basket = basketInstance
		}
		if(basketItemInstance.save(flush: true)) {
			println "Product $basketItemInstance.id created!"
			println "Product $basketItemInstance.user created!"
			println "Product $basketItemInstance.cost created!"
			println "Product $basketItemInstance.quantity created!"
			println "Product $basketItemInstance.good created!"
			redirect(controller:"basket", action:"addToBasket", id: basketItemInstance.id)
		} else {
			println "Product $basketItemInstance not added!"
			redirect(controller:"good")
		}
	}
	
	def addOne = {
		BasketItem p = BasketItem.get( params.id )
		p.cost = p.cost + p.good.price
		p.quantity += 1
		p.save()
		
		Basket b = Basket.get(session.user.id).save()

		// Add one more item
		b.itemCount += 1
		// Add the price of product
		b.basketCost += p.good.price

		session.basket = b
		redirect(controller:"basket", action:"show", id:"${session.user.id}")
	}
	
	def removeOne = {
		BasketItem p = BasketItem.get( params.id )
		if (p.quantity == 1) {
			redirect(controller:"basket", action:"removePurchase", id:"${p.id}")
		}
		else {
			p.cost = p.cost - p.good.price
			p.quantity -= 1
			p.save()
			
			Basket b = Basket.get(session.user.id).save()
	
			b.itemCount -= 1
			b.basketCost -= p.good.price
	
			session.basket = b
			redirect(controller:"basket", action:"show", id:"${session.user.id}")
		}
	}
	
	def findBasketItem(id) {
		def basketItemInstance = new BasketItem().find {id}
		return basketItemInstance
	}
}
