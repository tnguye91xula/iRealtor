import UIKit
import CloudKit

class AdminListRealtorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    var realtors: [RealtorInfo] = []
    var add = UIBarButtonItem()
    private var tbvc = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tbvc = tabBarController!
        view.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(RealtorCell.self, forCellReuseIdentifier: NSStringFromClass(RealtorCell))
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.tableView.reloadData()
        view.addSubview(tableView)
        
        let top = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let bottom = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let leading = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        let trailing = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem:view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activateConstraints([top, bottom, leading, trailing])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realtors.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(RealtorCell), forIndexPath: indexPath) as! RealtorCell
        cell.realtor = realtors[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(RealtorCell), forIndexPath: indexPath) as! RealtorCell
        cell.realtor = realtors[indexPath.row]
        
        var refreshAlert = UIAlertController(title: cell.realtor!.firstName! + cell.realtor!.lastName!, message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Edit", style: .Default, handler: { (action: UIAlertAction!) in
            var editViewControler = AddRealtorViewController()
            editViewControler.type = "Edit"
            editViewControler.realtorInfo = RealtorInfo(firstName: cell.realtor!.firstName!, lastName: cell.realtor!.lastName!, company: cell.realtor!.company!, realtorID: cell.realtor!.realtorID!, location: CLLocation(latitude:cell.realtor!.location!.coordinate.latitude ,longitude: cell.realtor!.location!.coordinate.longitude)!, contactNumber: cell.realtor!.contactNumber!, recordName: cell.realtor!.recordName!)
            self.presentViewController(editViewControler, animated: true, completion: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in
            println("Delete Button Pressed")
            self.deleteDatabaseRecord(cell.realtor!.recordName!)
            self.realtors.removeAtIndex(indexPath.row)
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
    
    func queryRealtors() {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "REALTOR", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            }
            else {
                for result in results {
                    let record:CKRecord = result as! CKRecord
                    var string = String()
                    var location:CLLocation = record.valueForKey("Location") as! CLLocation
                    var recordName = record.recordID.recordName
                    var firstName = record.valueForKey("FirstName") as! String
                    var lastName = record.valueForKey("LastName") as! String
                    var company = record.valueForKey("Company") as! String
                    var realtorID = record.valueForKey("RealtorID") as! Int
                    var contactNumber = record.valueForKey("ContactNumber") as! Int
                    var realtor = RealtorInfo(firstName: firstName, lastName: lastName, company: company, realtorID: realtorID, location: location, contactNumber: contactNumber, recordName: recordName)
                    self.realtors.append(realtor)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.tableView.reloadData()
                    })
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.realtors = []
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = add
        queryRealtors()
    }
    
    func addTapped(sender:UIButton!) {
        self.navigationController?.pushViewController(AddRealtorViewController(), animated: true)
    }
    
    func refreshTapped(sender:UIButton!) {
        let temp = AdminListRealtorsViewController()
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

