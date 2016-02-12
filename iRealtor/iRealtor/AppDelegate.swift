import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navController: UINavigationController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        navController = UINavigationController()
        
        var viewController: MapViewController = MapViewController()
        self.queryHouses(viewController.favoriteHouses)
        
        //        var viewController: AvailableHouseViewController = AvailableHouseViewController()
        //        viewController.add = UIBarButtonItem(barButtonSystemItem: .Add, target: viewController, action: "addTapped:")
        
        //        var viewController: AddHouseViewController = AddHouseViewController()
        //        var viewController: LoginViewController = LoginViewController()
        
        self.navController!.pushViewController(viewController, animated: false)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = navController
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func queryHouses(favoriteHouses: NSMutableArray) {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "HOUSE", predicate: predicate)
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            } else {
                for result in results {
                    let record:CKRecord = result as! CKRecord
                    var name = record.recordID.recordName
                    var bathR = record.valueForKey("Bathrooms") as! Int
                    var bedR = record.valueForKey("Bedrooms") as! Int
                    var hID = record.valueForKey("HouseID") as! Int
                    var location:CLLocation = record.valueForKey("Location") as! CLLocation
                    var price = record.valueForKey("Price") as! Int
                    var sold = record.valueForKey("Sold") as! Int
                    var assets: AnyObject = record.objectForKey("Photos")
                    let imageData = NSData(contentsOfURL: assets[0].fileURL)
                    var image = UIImage(data: imageData!)
                    var house = HouseInfo(name: name, bathrooms: bathR, bedrooms: bedR, houseID: hID, location: location, price: price, sold: sold, image: image!)
                    favoriteHouses.addObject(house)
                }
            }
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

