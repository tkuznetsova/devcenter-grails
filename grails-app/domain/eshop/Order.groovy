package eshop

import java.util.Date
import authentication.*

class Order {
	
	static belongsTo = [authentication: AuthenticationUser]
	
	static mapping = {
		table 'orders'
	}
	
	Long id
	AuthenticationUser authentication

	Date orderDate = new Date()
	Date requiredDate = orderDate + 14
	Double paymentAmount=1
	Date shippedDate
	Integer status=0
	
    static constraints = {
		paymentAmount blank: false, nullable: false
		shippedDate blank: true, nullable: true
		status(inList:[
			0, // new
			1  // payed
		])
    }
}