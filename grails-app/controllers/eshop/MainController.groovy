package eshop

import authentication.*

class MainController {

	List products
	List categories
	
	def user

	def index() {
		products = Good.findAll()
		categories = Category.list()
	
	}
	
	def authenticate = {
		user = AuthenticationUser.findByLoginAndPassword(params.login, params.password)
		if(user){
		  session.user = user
		  flash.message = "Hello ${user.name}!"
		  redirect(controller:"main", action:"index")
		}else{
		  flash.message = "Sorry, ${params.login}. Please try again."
		  redirect(controller:"authentication", action:"create")
		}
	  }

}
