package eshop

class Category {
	
	int id
	String name
	String description
	Category parent

	static hasMany = [good: Good]
	
    static constraints = {
		id blank: false, unique: true
		name blank: false, nullable: false, maxSize:20
		parent blank: true, nullable: true, maxSize:20
		description blank: true, nullable: true
    }
}
//http://stackoverflow.com/questions/4222483/can-we-have-more-than-one-field-in-gselect-optionvalue