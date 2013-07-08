package eshop

import authentication.*

class User extends AuthenticationUser {
	
	  static constraints = {
	    name(blank: true, nullable: true, maxSize:50)
		creditcardID creditCard: true, blank: false, nullable: false
		phone minSize:9, blank: false, nullable: false, maxSize:11
		addressline1(blank: false, nullable: false, maxSize:20) 
		addressline2(blank: true, nullable: true, maxSize:20) 
		city(blank: false, nullable: false, maxSize:20)
		stateregion(blank: true, nullable: true, maxSize:50)
		postalcode minSize:5, blank: false, nullable: false, maxSize:7
		country(blank: false, nullable: false, maxSize:10)
		creditlimit range: 0..1E8, blank: false, nullable: false
		role(blank: false, nullable: false, maxSize:10)
	  }
	  Long id
	  String name
	  String creditcardID  	    
	  String phone
	  String addressline1
	  String addressline2
	  String city
	  String stateregion
	  String postalcode
	  String country
	  Double creditlimit
	  String role
	  
	  String toString(){
	    name
		addressline1
		addressline2
		city
		stateregion
		country
		role
	  }

}
