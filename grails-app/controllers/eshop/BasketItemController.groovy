package eshop

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
	
	def addToBasket (Long id) {		
		// create domain object and assign parameters using data binding
		def product = Good.get( id )
		println "${product.name}"

		def p = new BasketItem(quantity:'1')
		p.user = session.user
		p.cost = product.price
		p.good = product
		p.save()

		if(p.save()) {
			println "Product $p.id created!"
			println "Product $p.user created!"
			println "Product $p.cost created!"
			println "Product $p.quantity created!"
			println "Product $p.good created!"
			redirect(controller:"basket",action:"addPurchase", id: p.id)

		} else {
			println "Product $p not added!"
			redirect(controller:"good")
		}

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
}
