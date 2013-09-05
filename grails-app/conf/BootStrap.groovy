class BootStrap {
	
	def mailService
	
    def init = { servletContext ->
		mailService.sendMail {
			to "trotilla87@gmail.com"
			subject "Hello %user%"
			body 'Hello! You have made an order in the WebShop. Your order details: http://localhost:8080/grails220/order/show'
		}
    }
    def destroy = {
    }
	
	
		
}
