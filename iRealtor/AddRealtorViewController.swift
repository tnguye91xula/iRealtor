import UIKit
import CloudKit

class AddRealtorViewController: UIViewController, UITextFieldDelegate {
    var type: String?
    var realtorInfo: RealtorInfo?
    private var tbvc = UITabBarController()
    let firstNameTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let lastNameTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let companyTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let locationLat : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let locationLong : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let contactNumberTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let recordNameTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let realtorIDTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tbvc = tabBarController!
        //myOrder = tbvc.order
        //self.navigationController!.navigationBar.translucent = false;
        
        let recordNameLabel = UILabel()
        recordNameLabel.text = "Record Name:"
        recordNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(recordNameLabel)
        
        let leadingrecordName =  NSLayoutConstraint(item: recordNameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let toprecordName = NSLayoutConstraint(item: recordNameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 10)
        
        let firstNameLabel = UILabel()
        firstNameLabel.text = "First Name:"
        firstNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(firstNameLabel)
        
        let leadingFirstNameLabel =  NSLayoutConstraint(item: firstNameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topFirstNameLabel = NSLayoutConstraint(item: firstNameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: recordNameLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        let lastNameLabel = UILabel()
        lastNameLabel.text = "Last Name:"
        lastNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(lastNameLabel)
        
        let leadingLastNameLabel =  NSLayoutConstraint(item: lastNameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topLastNameLabel = NSLayoutConstraint(item: lastNameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: firstNameLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        
        view.addSubview(recordNameTF)
        
        let leadingRecordNameTF =  NSLayoutConstraint(item: recordNameTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let topRecordNameTF = NSLayoutConstraint(item: recordNameTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant:10)
        let trailingRecordNameTF = NSLayoutConstraint(item: recordNameTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant:-10)
        
        
        view.addSubview(firstNameTF)
        
        let leadingFirstNameTF =  NSLayoutConstraint(item: firstNameTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: recordNameTF, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let topFirstNameTF = NSLayoutConstraint(item: firstNameTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: recordNameTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingFirstNameTF = NSLayoutConstraint(item: firstNameTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: recordNameTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant:0)
        
        
        view.addSubview(lastNameTF)
        
        let leadingLastNameTF =  NSLayoutConstraint(item: lastNameTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let topLastNameTF = NSLayoutConstraint(item: lastNameTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: lastNameLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant:0)
        let trailingLastNameTF = NSLayoutConstraint(item: lastNameTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10)
        
        let companyLabel = UILabel()
        companyLabel.text = "Company: "
        companyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(companyLabel)
        
        let leadingCompanyLabel =  NSLayoutConstraint(item: companyLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topCompanyLabel = NSLayoutConstraint(item: companyLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: lastNameLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        view.addSubview(companyTF)
        
        let leadingCompanyTF =  NSLayoutConstraint(item: companyTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let topCompanyTF = NSLayoutConstraint(item: companyTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: lastNameTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingCompanyTF = NSLayoutConstraint(item: companyTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant:-10)
        
        
        let location = UILabel()
        location.text = "Location Lat/Long:"
        location.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(location)
        
        let leadingLocation =  NSLayoutConstraint(item: location, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topLocation = NSLayoutConstraint(item: location, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: companyLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        view.addSubview(locationLat)
        
        let leadinglocationLat =  NSLayoutConstraint(item: locationLat, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let toplocationLat = NSLayoutConstraint(item: locationLat, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: companyTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailinglocationLat = NSLayoutConstraint(item: locationLat, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: companyTF, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: -5)
        
        
        view.addSubview(locationLong)
        
        let leadinglocationLong =  NSLayoutConstraint(item: locationLong, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: companyTF, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 5)
        let toplocationLong = NSLayoutConstraint(item: locationLong, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: companyTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailinglocationLong = NSLayoutConstraint(item: locationLong, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: companyTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        
        view.addSubview(contactNumberTF)
        
        let leadingpriceTF =  NSLayoutConstraint(item: contactNumberTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: companyTF, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let toppriceTF = NSLayoutConstraint(item: contactNumberTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: location, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingpriceTF = NSLayoutConstraint(item: contactNumberTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: companyTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let contactNumberLabel = UILabel()
        contactNumberLabel.text = "Contact Number:"
        contactNumberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(contactNumberLabel)
        
        let leadingContactNumber =  NSLayoutConstraint(item: contactNumberLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topContactNumber = NSLayoutConstraint(item: contactNumberLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: location, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        let realtorIDLabel = UILabel()
        realtorIDLabel.text = "Realtor ID:"
        realtorIDLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(realtorIDLabel)
        
        let leadingRealtorIDLabel =  NSLayoutConstraint(item: realtorIDLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topRealtorIDLabel = NSLayoutConstraint(item: realtorIDLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contactNumberLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        view.addSubview(realtorIDTF)
        
        let leadingrealtorIDTF =  NSLayoutConstraint(item: realtorIDTF, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contactNumberTF, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let topRealtorIDTF = NSLayoutConstraint(item: realtorIDTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contactNumberTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let trailingRealtorIDTF = NSLayoutConstraint(item: realtorIDTF, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contactNumberTF, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let saveButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        saveButton.backgroundColor = UIColor.whiteColor()
        
        saveButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(saveButton)
        
        let topSaveButton = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: realtorIDLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerSaveButton = NSLayoutConstraint(item: saveButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:0)
        
        let backButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        backButton.backgroundColor = UIColor.whiteColor()
        
        backButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(backButton)
        
        let topBackButton = NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: saveButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerBackButton = NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:0)
        backButton.setTitle("BACK", forState: UIControlState.Normal)
        backButton.addTarget(self, action: "backAction:", forControlEvents: UIControlEvents.TouchUpInside)

        
        NSLayoutConstraint.activateConstraints([leadingFirstNameLabel, topFirstNameLabel, leadingLastNameLabel, topLastNameLabel, leadingFirstNameTF, topFirstNameTF, trailingFirstNameTF, leadingLastNameTF, topLastNameTF, trailingLastNameTF, topSaveButton, centerSaveButton, leadingCompanyLabel, topCompanyLabel, leadingCompanyTF, topCompanyTF, trailingCompanyTF, leadingLocation, topLocation, leadinglocationLat, toplocationLat, trailinglocationLat, leadinglocationLong, toplocationLong, trailinglocationLong, leadingContactNumber, topContactNumber, leadingpriceTF, toppriceTF, trailingpriceTF, leadingRecordNameTF, topRecordNameTF, trailingRecordNameTF, leadingRealtorIDLabel, topRealtorIDLabel, leadingrealtorIDTF, topRealtorIDTF, trailingRealtorIDTF, leadingrecordName, toprecordName, topBackButton, centerBackButton])
        
        if (type == "Edit") {
            self.recordNameTF.text = "\(realtorInfo!.recordName!)"
            self.firstNameTF.text = "\(realtorInfo!.firstName!)"
            self.lastNameTF.text = "\(realtorInfo!.lastName!)"
            self.companyTF.text = "\(realtorInfo!.company!)"
            self.locationLat.text = "\(realtorInfo!.location!.coordinate.latitude)"
            self.locationLong.text = "\(realtorInfo!.location!.coordinate.longitude)"
            self.contactNumberTF.text = "\(realtorInfo!.contactNumber!)"
            self.realtorIDTF.text = "\(realtorInfo!.realtorID!)"
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
    
    func backAction(sender:UIButton!) {
        self.presentViewController(AdminOptionsViewController(), animated: true, completion: nil)
    }
    
    func writeRecord() {
        let recordID: CKRecordID = CKRecordID(recordName: self.recordNameTF.text)
        let record: CKRecord = CKRecord(recordType: "REALTOR", recordID: recordID)
        record.setObject(self.firstNameTF.text, forKey: "FirstName")
        record.setObject(self.lastNameTF.text, forKey: "LastName")
        record.setObject(self.companyTF.text, forKey: "Company")
        record.setObject(self.contactNumberTF.text.toInt(), forKey: "ContactNumber")
        record.setObject(self.realtorIDTF.text.toInt(), forKey: "RealtorID")
        var temp = CLLocationCoordinate2DMake(atof(self.locationLat.text), atof(self.locationLong.text))
        var location = CLLocation(latitude:temp.latitude ,longitude: temp.longitude)
        record.setObject(location, forKey: "Location")
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
        let recordID: CKRecordID = CKRecordID(recordName: realtorInfo!.recordName!)
        publicDatabase.fetchRecordWithID(recordID, completionHandler: { (record, error) -> Void in
            if error != nil {
                println("Error with update an record")
            }
            if record != nil {
                var temp = CLLocationCoordinate2DMake(atof(self.locationLat.text), atof(self.locationLong.text))
                var location = CLLocation(latitude:temp.latitude ,longitude: temp.longitude)
                record.setObject(location, forKey: "Location")
                record.setObject(self.firstNameTF.text, forKey: "FirstName")
                record.setObject(self.lastNameTF.text, forKey: "LastName")
                record.setObject(self.companyTF.text, forKey: "Company")
                record.setObject(self.contactNumberTF.text.toInt(), forKey: "ContactNumber")
                record.setObject(self.realtorIDTF.text.toInt(), forKey: "RealtorID")
                publicDatabase.saveRecord(record, completionHandler: { (updateRecord, updateError) -> Void in
                    if updateError != nil {
                        println("Error updating record")
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
