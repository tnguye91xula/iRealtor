import Foundation
import MapKit

class RealtorInfo: Printable {
    var firstName: String?
    var lastName: String?
    var company: String?
    var realtorID: Int?
    var contactNumber: Int?
    var location: CLLocation?
    var recordName: String?

    
    init(firstName: String, lastName: String, company: String, realtorID: Int, location: CLLocation, contactNumber: Int, recordName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.realtorID = realtorID
        self.contactNumber = contactNumber
        self.location = location
        self.recordName = recordName
    }
    
    var description:String {
        var fN = String(self.firstName!)
        var lN = String(self.lastName!)
        var comp = String(self.company!)
        //var loc = String(_cocoaString: self.location!)
        var rID = String(self.realtorID!)
        var contactN = String(self.contactNumber!)
        //var rID = String(self.realtorID!)
        
        
        
        return fN + " " + lN + " " + comp +  " " + rID + " " + contactN
    }

    
}