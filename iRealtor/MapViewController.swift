import UIKit
import MapKit
import CloudKit

class MapViewController: UIViewController,  MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    var favoriteHouses  = NSMutableArray()
    var annotations = NSMutableArray()
    var mapView = MKMapView()
    let locationManager = CLLocationManager()
    var edited: Bool = true
    var testUsername:String = ""
    var testPassword:String = ""
    private var tbvc = UITabBarController()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvc = tabBarController!
        //myOrder = tbvc.order
        self.edgesForExtendedLayout = UIRectEdge.None
        let filter = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "filterTapped:")
        self.navigationItem.rightBarButtonItems = [filter]
        
        let addHouse = UIBarButtonItem(title: "Admin Login", style: UIBarButtonItemStyle.Plain, target: self, action: "adminTapped:")
        self.navigationItem.leftBarButtonItems = [addHouse]
        
        /*let favorite = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.Plain, target: self, action: "favoriteTapped:")
        self.navigationItem.leftBarButtonItems = [favorite]*/
        
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
        for house in (favoriteHouses as NSArray as! [HouseInfo]) {
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
                var objectAnnotation = MKPointAnnotation()
                objectAnnotation.title = "Current Location"
                objectAnnotation.subtitle = "Latitude: \(pm.location.coordinate.latitude) Longitude: \(pm.location.coordinate.longitude)"
                objectAnnotation.coordinate = userCurrentLocationCoord
                self.annotations.addObject(objectAnnotation)
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
    
    func backToNormal(gestureRecognizer: UIGestureRecognizer) {
        var t: [AnyObject] = self.mapView.annotations
        self.mapView.removeAnnotations(t)
        mapView.addAnnotations(self.annotations as [AnyObject])
        let favorite = UIBarButtonItem(title: "Favorite", style: UIBarButtonItemStyle.Plain, target: self, action: "favoriteTapped:")
        self.navigationItem.leftBarButtonItems = [favorite]
        self.edited = true
    }
    
    func didTapMap(gestureRecognizer: UIGestureRecognizer) {
        if( self.edited == true) {
            let tapPoint: CGPoint = gestureRecognizer.locationInView(mapView)
            let touchMapCoordinate: CLLocationCoordinate2D = mapView.convertPoint(tapPoint, toCoordinateFromView: mapView)
            var objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = touchMapCoordinate
            objectAnnotation.title = "Latitude: \(objectAnnotation.coordinate.latitude) Longitude: \(objectAnnotation.coordinate.longitude)"
            self.annotations.addObject(objectAnnotation)
            self.mapView.addAnnotation(objectAnnotation)
            self.mapView.selectAnnotation(objectAnnotation, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

