import UIKit
import CloudKit
class LoginViewController: UIViewController, UITextFieldDelegate  {
    var testUsername:String = ""
    var testPassword:String = ""
    private var tbvc = UITabBarController()
    let usernameTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    let passwordTF : UITextField = UITextField.createUITextField(UIColor.whiteColor().CGColor, autoSizingContraint: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvc = tabBarController!
        self.view.backgroundColor = UIColor.whiteColor()
        usernameTF.frame = CGRectMake(85, 90, 200, 30)
        usernameTF.backgroundColor = UIColor.lightGrayColor()
        passwordTF.frame = CGRectMake(85, 170, 200, 30)
        passwordTF.backgroundColor = UIColor.lightGrayColor()
        let placeholderUsername = NSAttributedString(string: "Enter Username here", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        let placeholderPassword = NSAttributedString(string: "Enter Password here", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])

        usernameTF.attributedPlaceholder = placeholderUsername
        view.addSubview(usernameTF)
        
        passwordTF.attributedPlaceholder = placeholderPassword
        view.addSubview(passwordTF)
        
        let loginButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        loginButton.backgroundColor = UIColor.greenColor()
        loginButton.setTitle("Button", forState: UIControlState.Normal)
        loginButton.frame = CGRectMake(135, 225, 100, 50)
        loginButton.addTarget(self, action: "loginTouched:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginTouched(sender:UIButton!)
    {
        self.testUsername = usernameTF.text
        performQuery()
        if(passwordTF.text == self.testPassword) {
            self.presentViewController(AdminListRealtors(), animated: true, completion: nil)
        } else {
            println("false")
        }
    }
    
    func performQuery() {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        //let bobPredicate = [NSPredicate predicateWithFormat:@"Username = $self.testUsername")]
        let usernamePredicate = NSPredicate(format: "Username = %@", self.testUsername)
        let query = CKQuery(recordType: "ADMIN", predicate: usernamePredicate)
        var string = NSMutableString()
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            }
            else {
                let tr:CKRecord = results[0] as! CKRecord
                self.testPassword = tr.valueForKey("Password") as! String
                println(self.testPassword)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                })
            }
        }
    }
    
}
