package eshop

import java.io.Serializable
import authentication.*

class Basket implements Serializable {
			
	static hasMany = [purchase: BasketItem]
	static belongsTo = [user: AuthenticationUser]
	
	Long id
	int itemCount
	Double basketCost 
	
    static constraints = {
		id blank: false, nullable: false, unique: true 
		basketCost nullable: true
		itemCount nullable: true 
		purchase blank: true, nullable: true
    }
		
}
