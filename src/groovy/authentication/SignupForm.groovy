package authentication

import eshop.Basket
import org.codehaus.groovy.grails.validation.Validateable

@Validateable
class SignupForm implements Serializable {
	String login
	String email
	String password
	String passwordConfirm
	
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
	Basket basket
	boolean rememberMe
	
	static constraints = {
		login(size:6..40, blank:false, nullable: false)
		email(email:true, size:6..40, blank:false, nullable: false)
		password(size:6..40, password:true, blank:false, nullable: false)
		passwordConfirm(password:true, validator: { val, obj -> obj.password == val })
		
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
