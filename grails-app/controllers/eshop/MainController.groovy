package eshop

import authentication.*

class MainController {

	List products
	List categories

	def index = {
		products = Good.findAll()
		categories = Category.list()
	}
	
	def authenticate = {
		def user = AuthenticationUser.findByLoginAndPassword(params.login, params.password)
		if(user){
		  session.user = user
		  flash.message = "Hello ${user.name}!"
		  redirect(controller:"maint", action:"index")
		}else{
		  flash.message = "Sorry, ${params.login}. Please try again."
		  redirect(controller:"authentication", action:"create")
		}
	  }

}
