import UIKit
import CloudKit

class AdminAvailableHouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {
    var tableView = UITableView()
    var houses: [HouseInfo] = []
    var add = UIBarButtonItem()
    private var tbvc = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tbvc = tabBarController!
        view.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HouseCell.self, forCellReuseIdentifier: NSStringFromClass(HouseCell))
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.tableView.reloadData()
        view.addSubview(tableView)
        
        //Navigation Bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        
        navigationBar.backgroundColor = UIColor.clearColor()
        navigationBar.delegate = self;
        UINavigationBar.appearance().translucent = true
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "ALL HOUSES IN DATABASE "
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backAction:")
        
        navigationItem.leftBarButtonItem = backButton
        
        
        navigationBar.items = [navigationItem]
        
        
        self.view.addSubview(navigationBar)
        
        let top = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50)
        
        let bottom = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let leading = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        let trailing = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activateConstraints([top, bottom, leading, trailing])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(HouseCell), forIndexPath: indexPath) as! HouseCell
        cell.house = houses[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(HouseCell), forIndexPath: indexPath) as! HouseCell
        cell.house = houses[indexPath.row]
        
        var refreshAlert = UIAlertController(title: cell.house!.name, message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Edit", style: .Default, handler: { (action: UIAlertAction!) in
            var location: String = cell.house!.address!
            var geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(location) { (placemarks, error) -> Void in
                if (placemarks.count > 0) {
                    var topResult: CLPlacemark = placemarks[0] as! CLPlacemark
                    var editViewControler = AddHouseViewController()
                    editViewControler.type = "Edit"
                    editViewControler.houseInfo = HouseInfo(name: cell.house!.name!, bathrooms: cell.house!.bathrooms!, bedrooms: cell.house!.bedrooms!, houseID: cell.house!.houseID!, location: CLLocation(latitude:topResult.location.coordinate.latitude ,longitude: topResult.location.coordinate.longitude)!, price: cell.house!.price!, sold: cell.house!.sold!, realtorID: cell.house!.realtorID!)
                    self.presentViewController(editViewControler, animated: true, completion: nil)
                }
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in
            println("Delete Button Pressed")
            self.deleteDatabaseRecord(cell.house!.name!)
            self.houses.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
              presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func saveImageToFile(image: UIImage) -> NSURL {
        let dirPaths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        let docsDir: AnyObject = dirPaths[0]
        let filePath =
        docsDir.stringByAppendingPathComponent("testImage.png")
        UIImageJPEGRepresentation(image, 0.5).writeToFile(filePath,
            atomically: true)
        return NSURL.fileURLWithPath(filePath)!
    }
    
    func queryHouses() {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "HOUSE", predicate: predicate)
        
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
                       var house = HouseInfo(name: name, bathrooms: bathR, bedrooms: bedR, houseID: hID, address: string, price: price, sold: sold, image: image!, realtorID: rID)
                        self.houses.append(house)
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.houses = []
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = add
        queryHouses()
    }
    
    func addTapped(sender:UIButton!) {
        self.navigationController?.pushViewController(AddHouseViewController(), animated: true)
    }
    
    func backAction(sender:UIButton!) {
        self.presentViewController(AdminOptionsViewController(), animated: true, completion: nil)
    }
    
    func refreshTapped(sender:UIButton!) {
        let temp = AvailableHouseViewController()
        temp.add = UIBarButtonItem(barButtonSystemItem: .Add, target: temp, action: "addTapped:")
        self.navigationController?.pushViewController(temp, animated: true)
    }
    
    func deleteDatabaseRecord(recordName: String) {
        let defaultContainer: CKContainer = CKContainer.defaultContainer()
        let publicDataBase: CKDatabase = defaultContainer.publicCloudDatabase
        let recordID: CKRecordID = CKRecordID(recordName: recordName)
        publicDataBase.deleteRecordWithID(recordID, completionHandler: { (recordID, error) -> Void in
            if error != nil {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    println("Error with deleting an record")
                    self.tableView.reloadData()
                }
            } else {
                println("Deleting an record successful!!!")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

