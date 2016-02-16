//
//  House.swift
//  iRealtor
//
//  Created by Almore Cato II on 2/4/16.
//
//

import Foundation
import MapKit
import CloudKit


class House {
    var HouseID: Int
    var Price: Int
    var Location: CLLocation
    var Bedrooms: Int
    var Bathrooms: Int
    var Sold: Int
    var Photo: Array<CKAsset> = []
    init()
    {
        self.HouseID = 0
        self.Price = 0
        self.Location = CLLocation(latitude: 0, longitude: 0)
        self.Bedrooms = 0
        self.Bathrooms = 0
        self.Sold = 0
        self.Photo = []
    }
    
    init(HouseID: Int, Price: Int, Location: CLLocation, Bedrooms: Int, Bathrooms: Int, Sold: Int, Photo: Array<CKAsset>) {
        self.HouseID = HouseID
        self.Price = Price
        self.Location = Location
        self.Bedrooms = Bedrooms
        self.Bathrooms = Bathrooms
        self.Sold = Sold
        self.Photo = []
    }
    
    func locationToName() -> String {
        let geoCoder = CLGeocoder()
        var string = String()
        geoCoder.reverseGeocodeLocation(self.Location)
            {
                (placemarks, error) -> Void in
                if error != nil {
                    println(error)
                }
                else {

                
                let placeArray = placemarks as! [CLPlacemark]!
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                // Location name
                if let locationName = placeMark.addressDictionary?["Name"] as? String
                {
                    string += locationName
                }
                
                // City
                if let city = placeMark.addressDictionary?["City"] as? String
                {
                    string += ", " + city
                }
                
                // Zip code
                if let zip = placeMark.addressDictionary?["ZIP"] as? String
                {
                    string += ", " + zip
                    
                }
                }
                
    }
         println(string)
         return string
}
}