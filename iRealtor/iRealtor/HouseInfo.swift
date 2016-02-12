import Foundation
import MapKit

class HouseInfo {
    var name: String?
    var bathrooms: Int?
    var bedrooms: Int?
    var houseID: Int?
    var address: String?
    var price: Int?
    var sold: Int?
    var location: CLLocation?
    var image : UIImage?
    
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
}