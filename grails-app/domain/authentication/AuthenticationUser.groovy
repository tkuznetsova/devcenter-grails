package authentication

class AuthenticationUser { 
String login
	String password
	String email
	int status = AuthenticationService.STATUS_NEW
	
	def authenticationService
	
	Long id
	String name
	String creditcardID  	  // 4532302731121710
	String phone
	String addressline1
	String addressline2
	String city
	String stateregion
	String postalcode
	String country
	Double creditlimit
	String role
	Long basketId 
	
	String toString(){
	  name
	  addressline1
	  addressline2
	  city
	  stateregion
	  country
	  role
	}	
	
	static constraints = {
		basketId nullable: true, blank: false
		login(size:5..64, unique: true, validator: { val, obj -> obj.authenticationService.checkLogin(val) } )
		password(size:5..64, password: true, validator: { val, obj -> obj.authenticationService.checkPassword(val) })
		email(email:true, nullable: true, blank: false)
		status(inList:[
			AuthenticationService.STATUS_NEW, 
			AuthenticationService.STATUS_VALID, 
			AuthenticationService.STATUS_AWAITING_CONFIRMATION, 
			AuthenticationService.STATUS_CONFIRMATION_LAPSED
		])		
		name(blank: true, nullable: true, maxSize:50)					//
		creditcardID creditCard: true, blank: false, nullable: false	// r
		phone minSize:9, blank: false, nullable: false, maxSize:11		// r
		addressline1(blank: false, nullable: false, maxSize:20) 		// r
		addressline2(blank: true, nullable: true, maxSize:20)
		city(blank: false, nullable: false, maxSize:20)					// r
		stateregion(blank: true, nullable: true, maxSize:50)
		postalcode minSize:5, blank: false, nullable: false, maxSize:7	// r
		country(blank: false, nullable: false, maxSize:10)				// r
		creditlimit range: 0..1E8, blank: false, nullable: false		// r
		role(blank: false, nullable: false, maxSize:10)					// r
	}
}	
