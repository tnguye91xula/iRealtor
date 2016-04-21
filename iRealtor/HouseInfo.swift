import Foundation
import MapKit

class HouseInfo: NSObject, Printable, Equatable {
    var name: String?
    var bathrooms: Int?
    var bedrooms: Int?
    var houseID: Int?
    var address: String?
    var price: Int?
    var sold: Int?
    var location: CLLocation?
    var image : UIImage?
    var realtorID : Int?
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, address: String, price: Int, sold: Int, image: UIImage) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.address = address
        self.price = price
        self.sold = sold
        self.image = image
    }
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, location: CLLocation, price: Int, sold: Int, image: UIImage, realtorID: Int) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.location = location
        self.price = price
        self.sold = sold
        self.image = image
        self.realtorID = realtorID
    }
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, address: String, price: Int, sold: Int, image: UIImage, realtorID: Int) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.address = address
        self.price = price
        self.sold = sold
        self.image = image
        self.realtorID = realtorID
    }
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, location: CLLocation, price: Int, sold: Int, image: UIImage) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.location = location
        self.price = price
        self.sold = sold
        self.image = image
    }
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, address: String, price: Int, sold: Int) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.address = address
        self.price = price
        self.sold = sold
    }
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, location: CLLocation, price: Int, sold: Int) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.location = location
        self.price = price
        self.sold = sold
    }
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, location: CLLocation, price: Int, sold: Int, realtorID: Int) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.location = location
        self.price = price
        self.sold = sold
        self.realtorID = realtorID
    }
    
    init(name: String, bathrooms: Int, bedrooms: Int, houseID: Int, address: String, location: CLLocation, price: Int, sold: Int, realtorID: Int) {
        self.name = name
        self.bathrooms = bathrooms
        self.bedrooms = bedrooms
        self.houseID = houseID
        self.location = location
        self.price = price
        self.sold = sold
        self.realtorID = realtorID
        self.address = address
    }
    
    override
    var description:String {
        var bath = String(self.bathrooms!)
        var bed = String(self.bedrooms!)
        var hID = String(self.houseID!)
        var loc = self.address!
        var pr = String(self.price!)
        var sld = String(self.sold!)
        //var rID = String(self.realtorID!)


        
        return self.name! + " " + bath + " " + bed + " " + hID + " " + loc + " " + pr + " " + sld
    }
}

func == (lhs: HouseInfo, rhs: HouseInfo) -> Bool {
    return lhs.name == rhs.name && lhs.location == rhs.location
}