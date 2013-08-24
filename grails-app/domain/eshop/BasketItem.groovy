package eshop

import java.util.Date

class BasketItem {
	
	static hasMany = [good: Good]	
	static belongsTo = [user: User, basket: Basket, good: Good, order: Order]
	
	Long id
	int quantity
	Double cost
	Good good
	Basket basket
	Order order
	
    static constraints = {
		id blank: false, unique: true
		quantity nullable: true
		order nullable: true
		good nullable: true
		cost nullable: true
    }
	
}
