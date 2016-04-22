import UIKit
import MapKit
import CloudKit

class MapViewController: UIViewController,  MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    var favoriteHouses  = NSMutableArray()
    var houses: [HouseInfo] = []
    var annotations = NSMutableArray()
    var mapView = MKMapView()
    var globalLocation: CLLocation = CLLocation()
    let locationManager = CLLocationManager()
    var edited: Bool = true
    var testUsername:String = ""
    var testPassword:String = ""
    var queried: Bool = false
    var placedHouses: Bool = false
    private var tbvc = UITabBarController()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvc = tabBarController!
  
        self.edgesForExtendedLayout = UIRectEdge.None
        let filter = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "filterTapped:")
        self.navigationItem.rightBarButtonItems = [filter]
        
        let addHouse = UIBarButtonItem(title: "Admin Login", style: UIBarButtonItemStyle.Plain, target: self, action: "adminTapped:")
        self.navigationItem.leftBarButtonItems = [addHouse]
  
        
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
        self.view.addSubview(mapView)
        
        let leading =  NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        let trainiling = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let top =  NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let bottom =  NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activateConstraints([leading, trainiling, top, bottom])
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func filterTapped(sender:UIButton!) {
        println("Filter Button tapped")
    }
    func adminTapped(sender:UIButton!) {
        var vc: AddHouseViewController = AddHouseViewController()
        navigationController?.pushViewController(vc, animated: true )
    }

    
    func favoriteTapped(sender:UIButton!) {
        var t: [AnyObject] = self.mapView.annotations
        mapView.removeAnnotations(t)
        for house in (self.houses as NSArray as! [HouseInfo]) {
            var objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = CLLocationCoordinate2DMake(house.location!.coordinate.latitude, house.location!.coordinate.longitude)
            objectAnnotation.title = "Latitude: \(house.location!.coordinate.latitude) Longitude: \(house.location!.coordinate.longitude)"
            self.mapView.addAnnotation(objectAnnotation)
            self.mapView.selectAnnotation(objectAnnotation, animated: true)
        }
        self.edited = false
        let back = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backToNormal:")
        self.navigationItem.leftBarButtonItems = [back]
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
                let temploc = CLLocation(latitude: pm.location.coordinate.latitude, longitude: pm.location.coordinate.longitude)
                println("User Location")
                println(temploc)
                self.globalLocation = temploc
                if(!self.queried) {
                    self.queried = true
                    self.queryHouses(temploc)
                }
                let delay = 10 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                if(!self.placedHouses) {
                      self.placedHouses = true
                 dispatch_after(time, dispatch_get_main_queue()) {
                    println("Array size")
                    println(self.houses.count)
                    for house in self.houses {
                        let hLoc = CLLocationCoordinate2DMake(house.location!.coordinate.latitude, house.location!.coordinate.longitude)
                    var objectAnnotation = HouseAnnotation()
                    objectAnnotation.title = house.name!
                    /*objectAnnotation.subtitle = "Latitude: \(house.location!.coordinate.latitude) Longitude: \(house.location!.coordinate.longitude)"*/
                        objectAnnotation.subtitle = "Address: \(house.address!) Bathrooms: \(house.bathrooms!) Bedrooms: \(house.bedrooms!) Price: \(house.price!)"
                    objectAnnotation.coordinate = hLoc
                        objectAnnotation.bedrooms = house.bedrooms!
                        objectAnnotation.bathrooms = house.bathrooms!
                        objectAnnotation.price = house.price!
                    self.annotations.addObject(objectAnnotation)
                    self.mapView.addAnnotation(objectAnnotation)
                    //self.mapView.selectAnnotation(objectAnnotation, animated: true)
                    }
                }
            }
                
                self.displayLocationInfo(pm)
            } else {
                println("Error with the data.")
            }
        })
    }
    
    func queryHouses(userLocation: CLLocation) {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let radiusInKilometers = 60.00
       
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(Location, %@) < %f", userLocation, 32.1869)
        
        let locationPredicate = NSPredicate(format: "distanceToLocation:fromLocation:(%K,%@) < %f",
            "Location",
            userLocation,
            radiusInKilometers)
        
        let query = CKQuery(recordType: "HOUSE", predicate: locationPredicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            }
            else {
                for result in results {
                    let record:CKRecord = result as! CKRecord
                    var string = String()
                    var location:CLLocation = record.valueForKey("Location") as! CLLocation
                    let geoCoder = CLGeocoder()
                    geoCoder.reverseGeocodeLocation(location) {
                        (placemarks, error) -> Void in
                        let placeArray = placemarks as! [CLPlacemark]!
                        var placeMark: CLPlacemark!
                        placeMark = placeArray?[0]
                        if let locationName = placeMark.addressDictionary?["Name"] as? String {
                            string += locationName
                        }
                        if let city = placeMark.addressDictionary?["City"] as? String {
                            string += ", " + city
                        }
                        if let zip = placeMark.addressDictionary?["ZIP"] as? String {
                            string += ", " + zip
                        }
                        var name = record.recordID.recordName
                        var bathR = record.valueForKey("Bathrooms") as! Int
                        var bedR = record.valueForKey("Bedrooms") as! Int
                        var hID = record.valueForKey("HouseID") as! Int
                        var price = record.valueForKey("Price") as! Int
                        var sold = record.valueForKey("Sold") as! Int
                        var rID = record.valueForKey("RealtorID") as! Int
                        var assets: AnyObject = record.objectForKey("Photos")
                        let imageData = NSData(contentsOfURL: assets[0].fileURL)
                        var image = UIImage(data: imageData!)
                        var house = HouseInfo(name: name, bathrooms: bathR, bedrooms: bedR, houseID: hID, address: string, location: location, price: price, sold: sold, realtorID: rID)
                     
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.houses.append(house)

                        })
                    }
                }
            }
        }
    }
    
    func getLocation(name: String) -> CLLocation {
        return self.globalLocation
    }
    

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? HouseAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }

 
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
    }
    
    func backToNormal(gestureRecognizer: UIGestureRecognizer) {
        var t: [AnyObject] = self.mapView.annotations
        self.mapView.removeAnnotations(t)
        mapView.addAnnotations(self.annotations as [AnyObject])
        let favorite = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.Plain, target: self, action: "favoriteTapped:")
        self.navigationItem.leftBarButtonItems = [favorite]
        self.edited = true
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let house = view.annotation as! HouseAnnotation
        let alert = UIAlertView()
        alert.title = "House Info"
        alert.message = "Bedrooms: \(house.bedrooms) Bathrooms: \(house.bathrooms) Price: \(house.price)"
        alert.addButtonWithTitle("Exit")
        alert.show()
            
    
    }
    
    func didTapMap(gestureRecognizer: UIGestureRecognizer) {
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

