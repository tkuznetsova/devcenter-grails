package eshop;

class Good {
	
	static belongsTo = [category: Category]
		
	Long id;
	String name;
	Category category;
	Double price;
	String manufacturer;
	String characteristics;
	int stockAmount;
		
    static constraints = {
		id blank: false, unique: true
        name(blank: false, nullable: false, maxSize:20)
        price range: 0..1E8, blank: false, nullable: false, unsigned: true
		stockAmount range: 0..1E8, blank: false
		manufacturer(maxSize:20)
		characteristics(maxSize:20)
	
    }
	
	String toString(){
		name
		manufacturer
		characteristics
    }
	
}
