//
//  MapViewController.swift
//  iRealtor
//
//  Created by Tuan Nguyen on 2/1/16.
//  Copyright (c) 2016 Tuan Nguyen. All rights reserved.
//

import UIKit

import MapKit

class MapViewController: UIViewController,  MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let longTextField = UITextField()
    let latTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.mapType = MKMapType.Standard
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        mapView.showsUserLocation = true
        mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapMap:")
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(singleTap)
        
        
        let latLabel = UILabel()
        latLabel.text = "Latitude: "
        latLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let longLabel = UILabel()
        longLabel.text = "Longitude: "
        longLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        latTextField.layer.backgroundColor = UIColor.whiteColor().CGColor
        latTextField.layer.borderColor = UIColor.grayColor().CGColor
        latTextField.layer.borderWidth = 0.0
        latTextField.layer.cornerRadius = 3
        latTextField.layer.masksToBounds = false
        latTextField.layer.shadowRadius = 2.0
        latTextField.layer.shadowColor = UIColor.blackColor().CGColor
        latTextField.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        latTextField.layer.shadowOpacity = 1.0
        latTextField.delegate = self
        latTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        longTextField.layer.backgroundColor = UIColor.whiteColor().CGColor
        longTextField.layer.borderColor = UIColor.grayColor().CGColor
        longTextField.layer.borderWidth = 0.0
        longTextField.layer.cornerRadius = 3
        longTextField.layer.masksToBounds = false
        longTextField.layer.shadowRadius = 2.0
        longTextField.layer.shadowColor = UIColor.blackColor().CGColor
        longTextField.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        longTextField.layer.shadowOpacity = 1.0
        longTextField.delegate = self
        longTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addSubview(mapView)
        self.view.addSubview(latLabel)
        self.view.addSubview(longLabel)
        self.view.addSubview(latTextField)
        self.view.addSubview(longTextField)
        
        let leading =  NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        let trainiling = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let top =  NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let leadingLabel =  NSLayoutConstraint(item: latLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        
        let bottomLabel = NSLayoutConstraint(item: latLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -80)
        
        let bottom = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: latLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -20)
        
        let leadingLong =  NSLayoutConstraint(item: longLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        
        let trainilingLong = NSLayoutConstraint(item: longLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 10)
        
        let topLong = NSLayoutConstraint(item: longLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: latLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 40)
        
        let leadingLatTextField = NSLayoutConstraint(item: latTextField, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        let trailingLatTextField = NSLayoutConstraint(item: latTextField, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10)
        
        let bottomLatTextField = NSLayoutConstraint(item: latTextField, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: latLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let topLongTextField = NSLayoutConstraint(item: longTextField, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: latTextField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 40)
        
        let leadingLongTextField = NSLayoutConstraint(item: longTextField, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        let trailingLongTextField = NSLayoutConstraint(item: longTextField, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10)
        
        NSLayoutConstraint.activateConstraints([leading, trainiling, top, bottom, leadingLabel, bottomLabel, leadingLong, trainilingLong, topLong, bottomLatTextField, leadingLatTextField, trailingLatTextField, topLongTextField, leadingLongTextField, trailingLongTextField, bottomLatTextField])
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(!self.latTextField.text.isEmpty && !self.longTextField.text.isEmpty && self.latTextField.selected == false && self.longTextField.selected == false) {
            var objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = CLLocationCoordinate2DMake(atof(self.latTextField.text), atof(self.longTextField.text))
            objectAnnotation.title = "Latitude: \(objectAnnotation.coordinate.latitude) Longitude: \(objectAnnotation.coordinate.longitude)"
            self.mapView.addAnnotation(objectAnnotation)
            self.mapView.selectAnnotation(objectAnnotation, animated: true)
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                let userCurrentLocationCoord = CLLocationCoordinate2D(latitude: pm.location.coordinate.latitude, longitude: pm.location.coordinate.longitude)
                var objectAnnotation = MKPointAnnotation()
                objectAnnotation.title = "Current Location"
                objectAnnotation.subtitle = "Latitude: \(pm.location.coordinate.latitude) Longitude: \(pm.location.coordinate.longitude)"
                objectAnnotation.coordinate = userCurrentLocationCoord
                self.mapView.addAnnotation(objectAnnotation)
                self.mapView.selectAnnotation(objectAnnotation, animated: true)
                self.displayLocationInfo(pm)
            } else {
                println("Error with the data.")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
    }
    
    func didTapMap(gestureRecognizer: UIGestureRecognizer) {
        let tapPoint: CGPoint = gestureRecognizer.locationInView(mapView)
        let touchMapCoordinate: CLLocationCoordinate2D = mapView.convertPoint(tapPoint, toCoordinateFromView: mapView)
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = touchMapCoordinate
        objectAnnotation.title = "Latitude: \(objectAnnotation.coordinate.latitude) Longitude: \(objectAnnotation.coordinate.longitude)"
        self.mapView.addAnnotation(objectAnnotation)
        self.mapView.selectAnnotation(objectAnnotation, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

