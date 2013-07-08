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
		println params
		def user = AuthenticationUser.findByLogin(session.user.login)
		println user.login
		if(user){
		  session.user = user
		  flash.message = "Hello ${user.login}!"
		  redirect(controller:"main", action:"index")
		}else{
		  flash.message = "Sorry, ${params.login}. Please try again."
		  redirect(controller:"authentication", action:"login")
		}
	  }

}
