package eshop

import java.io.Serializable
import authentication.*

class Basket implements Serializable {
			
	static hasMany = [purchase: BasketItem]
	static belongsTo = [user: AuthenticationUser]
	
	int itemCount
	Double basketCost 
	
    static constraints = {
		user blank: true, nullable: true // cannot do a new AuthenticationUser from BasketController
		basketCost nullable: true
		itemCount nullable: true 
		purchase blank: true, nullable: true
    }
		
}
