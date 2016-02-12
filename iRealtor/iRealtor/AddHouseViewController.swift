import UIKit
import CloudKit

class AddHouseViewController: UIViewController, UITextFieldDelegate {
    var type: String?
    var houseInfo: HouseInfo?
    let bathroomsTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let bedroomsTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let houseIDTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let locationLat : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let locationLong : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let priceTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let realtorIDTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let soldTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false;
        
        let recordName = UILabel()
        recordName.text = "Record Name:"
        recordName.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(recordName)
        
        let leadingrecordName =  NSLayoutConstraint(item: recordName, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let toprecordName = NSLayoutConstraint(item: recordName, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 10)
        
        let bathrooms = UILabel()
        bathrooms.text = "Bathrooms:"
        bathrooms.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(bathrooms)
        
        let leadingBathroom =  NSLayoutConstraint(item: bathrooms, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topBathroom = NSLayoutConstraint(item: bathrooms, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: recordName, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        let bedrooms = UILabel()
        bedrooms.text = "Bedroom:"
        bedrooms.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(bedrooms)
        
        let leadingBedroom =  NSLayoutConstraint(item: bedrooms, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topBedroom = NSLayoutConstraint(item: bedrooms, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bathrooms, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        
        view.addSubview(realtorIDTF)
        
        let leadingrealtorIDTF =  NSLayoutConstraint(item: realtorIDTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let toprealtorIDTF = NSLayoutConstraint(item: realtorIDTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant:10)
        let trailingrealtorIDTF = NSLayoutConstraint(item: realtorIDTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant:-10)
        
        
        view.addSubview(bathroomsTF)
        
        let leadingBathroomsTF =  NSLayoutConstraint(item: bathroomsTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: realtorIDTF, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let topBathroomsTF = NSLayoutConstraint(item: bathroomsTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: realtorIDTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingBathroomsTF = NSLayoutConstraint(item: bathroomsTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: realtorIDTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant:0)
        
        
        view.addSubview(bedroomsTF)
        
        let leadingBedroomsTF =  NSLayoutConstraint(item: bedroomsTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        let topBedroomsTF = NSLayoutConstraint(item: bedroomsTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bedrooms, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant:0)
        let trailingBedroomsTF = NSLayoutConstraint(item: bedroomsTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10)
        
        let houseID = UILabel()
        houseID.text = "House ID: "
        houseID.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(houseID)
        
        let leadingHouseID =  NSLayoutConstraint(item: houseID, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topHouseID = NSLayoutConstraint(item: houseID, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bedrooms, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        view.addSubview(houseIDTF)
        
        let leadingHouseIDTF =  NSLayoutConstraint(item: houseIDTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let topHouseIDTF = NSLayoutConstraint(item: houseIDTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bedroomsTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingHouseIDTF = NSLayoutConstraint(item: houseIDTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant:-10)
        
        
        let location = UILabel()
        location.text = "Location Lat/Long:"
        location.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(location)
        
        let leadingLocation =  NSLayoutConstraint(item: location, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topLocation = NSLayoutConstraint(item: location, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: houseID, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        view.addSubview(locationLat)
        
        let leadinglocationLat =  NSLayoutConstraint(item: locationLat, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let toplocationLat = NSLayoutConstraint(item: locationLat, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: houseIDTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailinglocationLat = NSLayoutConstraint(item: locationLat, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: houseIDTF, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: -5)
        
        
        view.addSubview(locationLong)
        
        let leadinglocationLong =  NSLayoutConstraint(item: locationLong, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: houseIDTF, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 5)
        let toplocationLong = NSLayoutConstraint(item: locationLong, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: houseIDTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailinglocationLong = NSLayoutConstraint(item: locationLong, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: houseIDTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        
        view.addSubview(priceTF)
        
        let leadingpriceTF =  NSLayoutConstraint(item: priceTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: houseIDTF, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let toppriceTF = NSLayoutConstraint(item: priceTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: location, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingpriceTF = NSLayoutConstraint(item: priceTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: houseIDTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let price = UILabel()
        price.text = "Price:"
        price.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(price)
        
        let leadingprice =  NSLayoutConstraint(item: price, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topprice = NSLayoutConstraint(item: price, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: location, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        let sold = UILabel()
        sold.text = "Sold:"
        sold.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(sold)
        
        let leadingsold =  NSLayoutConstraint(item: sold, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topsold = NSLayoutConstraint(item: sold, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: price, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        view.addSubview(soldTF)
        
        let leadingsoldTF =  NSLayoutConstraint(item: soldTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: priceTF, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let topsoldTF = NSLayoutConstraint(item: soldTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: priceTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingsoldTF = NSLayoutConstraint(item: soldTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: priceTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let saveButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        saveButton.backgroundColor = UIColor.whiteColor()
        
        saveButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(saveButton)
        
        let topSaveButton = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: sold, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerSaveButton = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:0)
        
        NSLayoutConstraint.activateConstraints([leadingBathroom, topBathroom, leadingBedroom, topBedroom, leadingBathroomsTF, topBathroomsTF, trailingBathroomsTF, leadingBedroomsTF, topBedroomsTF, trailingBedroomsTF, topSaveButton, centerSaveButton, leadingHouseID, topHouseID, leadingHouseIDTF, topHouseIDTF, trailingHouseIDTF, leadingLocation, topLocation, leadinglocationLat, toplocationLat, trailinglocationLat, leadinglocationLong, toplocationLong, trailinglocationLong, leadingprice, topprice, leadingpriceTF, toppriceTF, trailingpriceTF, leadingrealtorIDTF, toprealtorIDTF, trailingrealtorIDTF, leadingsold, topsold, leadingsoldTF, topsoldTF, trailingsoldTF, leadingrecordName, toprecordName])
        
        if (type == "Edit") {
            self.realtorIDTF.text = "\(houseInfo!.name!)"
            self.bathroomsTF.text = "\(houseInfo!.bathrooms!)"
            self.bedroomsTF.text = "\(houseInfo!.bedrooms!)"
            self.houseIDTF.text = "\(houseInfo!.houseID!)"
            self.locationLat.text = "\(houseInfo!.location!.coordinate.latitude)"
            self.locationLong.text = "\(houseInfo!.location!.coordinate.longitude)"
            self.priceTF.text = "\(houseInfo!.price!)"
            self.soldTF.text = "\(houseInfo!.sold!)"
            saveButton.setTitle("Edit", forState: UIControlState.Normal)
            saveButton.addTarget(self, action: "updateAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
        } else {
            saveButton.setTitle("SAVE", forState: UIControlState.Normal)
            saveButton.addTarget(self, action: "addAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
        let countdots = textField.text.componentsSeparatedByString(".").count - 1
        
        if countdots > 0 && string == "." {
            return false
        }
        return true
    }
    
    func saveImageToFile(image: UIImage) -> NSURL {
        let dirPaths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        let docsDir: AnyObject = dirPaths[0]
        let filePath = docsDir.stringByAppendingPathComponent("testImage.png")
        UIImageJPEGRepresentation(image, 0.5).writeToFile(filePath,
            atomically: true)
        return NSURL.fileURLWithPath(filePath)!
    }
    
    func updateAction(sender:UIButton!) {
        updateRecord()
        var temp = AvailableHouseViewController()
        temp.add = UIBarButtonItem(barButtonSystemItem: .Refresh, target: temp, action: "refreshTapped:")
        self.navigationController?.pushViewController(temp, animated: true)
    }
    
    func addAction(sender:UIButton!) {
        writeRecord()
        var temp = AvailableHouseViewController()
        temp.add = UIBarButtonItem(barButtonSystemItem: .Refresh, target: temp, action: "refreshTapped:")
        self.navigationController?.pushViewController(temp, animated: true)
    }
    
    func writeRecord() {
        let recordID: CKRecordID = CKRecordID(recordName: self.realtorIDTF.text)
        let record: CKRecord = CKRecord(recordType: "HOUSE", recordID: recordID)
        record.setObject(self.bathroomsTF.text.toInt(), forKey: "Bathrooms")
        record.setObject(self.bedroomsTF.text.toInt(), forKey: "Bedrooms")
        record.setObject(self.houseIDTF.text.toInt(), forKey: "HouseID")
        record.setObject(self.priceTF.text.toInt(), forKey: "Price")
        record.setObject(self.soldTF.text.toInt(), forKey: "Sold")
        var temp = CLLocationCoordinate2DMake(atof(self.locationLat.text), atof(self.locationLong.text))
        var location = CLLocation(latitude:temp.latitude ,longitude: temp.longitude)
        record.setObject(location, forKey: "Location")
        let asset = CKAsset(fileURL: self.saveImageToFile(UIImage(named: "testImage")!))
        var assets: [CKAsset] = []
        assets.append(asset)
        record.setObject(assets, forKey: "Photos")
        let defaultContainer: CKContainer = CKContainer.defaultContainer()
        let publicDatabase: CKDatabase = defaultContainer.publicCloudDatabase
        
        publicDatabase.saveRecord(record, completionHandler: { (record, error) -> Void in
            if error != nil {
                println("Error with writing new record")
            }
            if record != nil {
                println("Saved!!!")
            }
        })
    }
    
    func updateRecord() {
        let defaultContainer: CKContainer = CKContainer.defaultContainer()
        let publicDatabase: CKDatabase = defaultContainer.publicCloudDatabase
        let recordID: CKRecordID = CKRecordID(recordName: houseInfo!.name!)
        publicDatabase.fetchRecordWithID(recordID, completionHandler: { (record, error) -> Void in
            if error != nil {
                println("Error with update an record")
            }
            if record != nil {
                var temp = CLLocationCoordinate2DMake(atof(self.locationLat.text), atof(self.locationLong.text))
                var location = CLLocation(latitude:temp.latitude ,longitude: temp.longitude)
                record.setObject(location, forKey: "Location")
                record.setObject(self.bathroomsTF.text.toInt(), forKey: "Bathrooms")
                record.setObject(self.bedroomsTF.text.toInt(), forKey: "Bedrooms")
                record.setObject(self.houseIDTF.text.toInt(), forKey: "HouseID")
                record.setObject(self.priceTF.text.toInt(), forKey: "Price")
                record.setObject(self.soldTF.text.toInt(), forKey: "Sold")
                let asset = CKAsset(fileURL: self.saveImageToFile(UIImage(named: "testImage")!))
                var assets: [CKAsset] = []
                assets.append(asset)
                record.setObject(assets, forKey: "Photos")
                publicDatabase.saveRecord(record, completionHandler: { (updateRecord, updateError) -> Void in
                    if updateError != nil {
                        println("Error with update record while trying to save the updating record")
                    }
                    if updateRecord != nil {
                        println("Saved!!!")
                    }
                })
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
