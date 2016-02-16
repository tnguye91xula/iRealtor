import UIKit
import CloudKit

class ViewController: UIViewController {
    var testUsername:String = ""
    var testPassword:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBAction func verifyLogin(sender: AnyObject) {
        var usr: String = "login"
        var pass: String = "pass"
        performQuery()
        if(textFieldUsername.text == self.testUsername && textFieldPassword.text == self.testPassword) {
            println("true")
        } else {
            println("false")
        }
    }
    
    @IBOutlet weak var textFieldPassword: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func performQuery() {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "ADMIN", predicate: predicate)
        var string = NSMutableString()
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            }
            else {
                let tr:CKRecord = results[0] as! CKRecord
                self.testUsername = tr.valueForKey("Username") as! String
                self.testPassword = tr.valueForKey("Password") as! String
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                })
            }
        }
    }
}

