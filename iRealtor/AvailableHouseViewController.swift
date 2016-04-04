import UIKit
import CloudKit

class AvailableHouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {
    var tableView = UITableView()
    var houses: [HouseInfo] = []
    var add = UIBarButtonItem()
    var filterButtonClicked = false
    private var tbvc = UITabBarController()
    let bathroomsFilterTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let bedroomsFilterTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let priceFilterTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let filterSendButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvc = tabBarController!
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
        navigationItem.title = "Houses Around You "
        
        let filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "filterAction:")
       
        navigationItem.rightBarButtonItem = filterButton
        
        navigationBar.items = [navigationItem]
        
      
        self.view.addSubview(navigationBar)
        
        //FILTER TEXTBOXES
        view.addSubview(bathroomsFilterTF)
        let placeholderBathrooms = NSAttributedString(string: "Enter bathrooms here", attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
        let placeholderBedrooms = NSAttributedString(string: "Enter bedrooms here", attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
        let placeholderPrice = NSAttributedString(string: "Enter price here", attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
        
        bathroomsFilterTF.attributedPlaceholder = placeholderBathrooms
        bedroomsFilterTF.attributedPlaceholder = placeholderBedrooms
        priceFilterTF.attributedPlaceholder = placeholderPrice

        let leadingBathroomsTF =  NSLayoutConstraint(item: bathroomsFilterTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let topBathroomsTF = NSLayoutConstraint(item: bathroomsFilterTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant:40)
        let trailingBathroomsTF = NSLayoutConstraint(item: bathroomsFilterTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant:-10)
        
        
        
        
        view.addSubview(bedroomsFilterTF)
        
        let leadingBedroomsTF =  NSLayoutConstraint(item: bedroomsFilterTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        let topBedroomsTF = NSLayoutConstraint(item: bedroomsFilterTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bathroomsFilterTF, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant:30)
        let trailingBedroomsTF = NSLayoutConstraint(item: bedroomsFilterTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10)
        
        view.addSubview(priceFilterTF)
    
        
        let leadingPriceTF =  NSLayoutConstraint(item: priceFilterTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        let topPriceTF = NSLayoutConstraint(item: priceFilterTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bedroomsFilterTF, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant:30)
        let trailingPriceTF = NSLayoutConstraint(item: priceFilterTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10)
        
        //FILTER BUTTON
        //let filterSendButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
        filterSendButton.backgroundColor = UIColor.whiteColor()
        filterSendButton.setTitle("SEND", forState: UIControlState.Normal)
        filterSendButton.addTarget(self, action: "filterSendAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        filterSendButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(filterSendButton)
        
        let topFilterSendButton = NSLayoutConstraint(item: filterSendButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: priceFilterTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerFilterSendButton = NSLayoutConstraint(item: filterSendButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: priceFilterTF, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)



        
        //TABLE CONSTRAINTS
        
        let topTable = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50)
        
        let bottomTable = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let leadingTable = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        let trailingTable = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activateConstraints([topTable, bottomTable, leadingTable, trailingTable, topBathroomsTF, topBedroomsTF,topPriceTF, topFilterSendButton, leadingBathroomsTF,leadingBedroomsTF, leadingPriceTF, trailingBedroomsTF, trailingBathroomsTF, trailingPriceTF, centerFilterSendButton])
        
        self.bedroomsFilterTF.hidden = true;
        self.bathroomsFilterTF.hidden = true;
        self.priceFilterTF.hidden = true;
        self.filterSendButton.hidden = true;
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
    

        
        refreshAlert.addAction(UIAlertAction(title: "Add To Favorite", style: .Default, handler: { (action: UIAlertAction!) in
            println("Add To Favorite")
            var location: String = cell.house!.address!
            var geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(location) { (placemarks, error) -> Void in
                if (placemarks.count > 0) {
                    var topResult: CLPlacemark = placemarks[0] as! CLPlacemark
                    let recordID: CKRecordID = CKRecordID(recordName: cell.house?.name)
                    let record: CKRecord = CKRecord(recordType: "HOUSE", recordID: recordID)
                    record.setObject(cell.house?.bathrooms, forKey: "Bathrooms")
                    record.setObject(cell.house?.bedrooms, forKey: "Bedrooms")
                    record.setObject(cell.house?.houseID, forKey: "HouseID")
                    record.setObject(cell.house?.price, forKey: "Price")
                    record.setObject(cell.house?.sold, forKey: "Sold")
                    var temp = CLLocationCoordinate2DMake(topResult.location.coordinate.latitude, topResult.location.coordinate.longitude)
                    var location = CLLocation(latitude:temp.latitude ,longitude: temp.longitude)
                    record.setObject(location, forKey: "Location")
                    let asset = CKAsset(fileURL: self.saveImageToFile(cell.house!.image!))
                    var assets: [CKAsset] = []
                    assets.append(asset)
                    record.setObject(assets, forKey: "Photos")
                    let defaultContainer: CKContainer = CKContainer.defaultContainer()
                    let publicDatabase: CKDatabase = defaultContainer.privateCloudDatabase
                    publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
                        if error != nil {
                            println("Error with saving an record into private database")
                        }
                        if record != nil {
                            println("Saved!!!")
                        }
                    })
                }
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func filterAction(sender:UIButton!) {
        if(!filterButtonClicked) {
            self.bedroomsFilterTF.hidden = false;
            self.bathroomsFilterTF.hidden = false;
            self.priceFilterTF.hidden = false;
            self.filterSendButton.hidden = false;
            self.filterButtonClicked = true;
        } else {
            self.bedroomsFilterTF.hidden = true;
            self.bathroomsFilterTF.hidden = true;
            self.priceFilterTF.hidden = true;
            self.filterSendButton.hidden = true;
            self.filterButtonClicked = false;
        }
    }
    
    func filterSendAction(sender:UIButton!) {
        if (!self.bathroomsFilterTF.text.isEmpty) {
            self.houses = self.houses.filter({$0.bathrooms >= self.bathroomsFilterTF.text.toInt()})
        }
        if (!self.bedroomsFilterTF.text.isEmpty) {
            self.houses = self.houses.filter({$0.bedrooms >= self.bedroomsFilterTF.text.toInt()})
        }
        if (!self.priceFilterTF.text.isEmpty) {
            self.houses = self.houses.filter({$0.price <= self.priceFilterTF.text.toInt()})
        }
        self.tableView.reloadData()
        
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
                        var assets: AnyObject = record.objectForKey("Photos")
                        let imageData = NSData(contentsOfURL: assets[0].fileURL)
                        var image = UIImage(data: imageData!)
                        var house = HouseInfo(name: name, bathrooms: bathR, bedrooms: bedR, houseID: hID, address: string, price: price, sold: sold, image: image!)
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

