//
//  House.swift
//  iRealtor
//
//  Created by Almore Cato II on 2/4/16.
//  Copyright (c) 2016 Tuan Nguyen. All rights reserved.
//

import Foundation
import MapKit

class User {
    var HouseID: Int
    var Price: Int
    var Location: CLLocation
    var Bedrooms: Int
    var Bathrooms: Int
    var Sold: Int
    var Photo: Array<UIImage> = []
    
    init(HouseID: Int, Price: Int, Location: CLLocation, Bedrooms: Int, Bathrooms: Int, Sold: Int, Photo: Array<UIImage>) {
        self.HouseID = HouseID
        self.Price = Price
        self.Location = Location
        self.Bedrooms = Bedrooms
        self.Bathrooms = Bathrooms
        self.Sold = Sold
        self.Photo = Photo
    }
}
