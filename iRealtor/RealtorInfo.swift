import Foundation
import MapKit

class RealtorInfo {
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
    
    
}