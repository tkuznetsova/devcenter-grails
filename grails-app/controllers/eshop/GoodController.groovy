package eshop

import org.springframework.dao.DataIntegrityViolationException

class GoodController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [goodInstanceList: Good.list(params), goodInstanceTotal: Good.count()]
    }

    def create() {
        [goodInstance: new Good(params)]
    }

    def save() {
        def goodInstance = new Good(params)
        if (!goodInstance.save(flush: true)) {
            render(view: "create", model: [goodInstance: goodInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'good.label', default: 'Good'), goodInstance.id])
        redirect(action: "show", id: goodInstance.id)
    }

    def show(Long id) {
        def goodInstance = Good.get(id)
        if (!goodInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'good.label', default: 'Good'), id])
            redirect(action: "list")
            return
        }

        [goodInstance: goodInstance]
    }

    def edit(Long id) {
        def goodInstance = Good.get(id)
        if (!goodInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'good.label', default: 'Good'), id])
            redirect(action: "list")
            return
        }

        [goodInstance: goodInstance]
    }

    def update(Long id, Long version) {
        def goodInstance = Good.get(id)
        if (!goodInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'good.label', default: 'Good'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (goodInstance.version > version) {
                goodInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'good.label', default: 'Good')] as Object[],
                          "Another user has updated this Good while you were editing")
                render(view: "edit", model: [goodInstance: goodInstance])
                return
            }
        }

        goodInstance.properties = params

        if (!goodInstance.save(flush: true)) {
            render(view: "edit", model: [goodInstance: goodInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'good.label', default: 'Good'), goodInstance.id])
        redirect(action: "show", id: goodInstance.id)
    }

    def delete(Long id) {
        def goodInstance = Good.get(id)
        if (!goodInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'good.label', default: 'Good'), id])
            redirect(action: "list")
            return
        }

        try {
            goodInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'good.label', default: 'Good'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'good.label', default: 'Good'), id])
            redirect(action: "show", id: id)
        }
    }
}
