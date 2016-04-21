//
//  HouseAnnotation.swift
//  iRealtor
//
//  Created by Almore Cato II on 4/21/16.
//  Copyright (c) 2016 Tuan Nguyen. All rights reserved.
//

import Foundation
import MapKit

class HouseAnnotation: NSObject, MKMapViewDelegate, MKAnnotation {
   
    var title: String
    var subtitle: String
    var coordinate: CLLocationCoordinate2D
    var bedrooms: Int
    var bathrooms: Int
    var price: Int
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.coordinate = CLLocationCoordinate2D()
        self.bedrooms = 0
        self.bathrooms = 0
        self.price = 0
    }
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, bedrooms: Int, bathrooms: Int, price: Int) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.price = price
    }

}