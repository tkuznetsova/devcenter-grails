package eshop

import java.util.Date

class Order {
	
	static belongsTo = [user: User]
	
	static mapping = {
		table 'orders'
	}
	
	Long id
	User user
	Date orderDate
	Date requiredDate
	Double paymentAmount=1
	Date shippedDate
	Integer status=0
	
    static constraints = {
		id blank: false, nullable: false, unique: true
		paymentAmount blank: false, nullable: false
    }
}