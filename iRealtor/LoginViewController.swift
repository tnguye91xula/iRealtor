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
        /*usernameTF.frame = CGRectMake(85, 90, 200, 30)
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
        self.view.addSubview(loginButton)*/
        //self.navigationController
        let placeholderUsername = NSAttributedString(string: "Enter Username here", attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
        let placeholderPassword = NSAttributedString(string: "Enter Password here", attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
        
        usernameTF.attributedPlaceholder = placeholderUsername
        //view.addSubview(usernameTF)
        
        passwordTF.attributedPlaceholder = placeholderPassword
        //view.addSubview(passwordTF)
        
        let viewTitle = UILabel()
        viewTitle.text = ""
        viewTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(viewTitle)
        
        let leadingViewTitle =  NSLayoutConstraint(item: viewTitle, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topViewTitle = NSLayoutConstraint(item: viewTitle, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 10)
        let centerViewTitle = NSLayoutConstraint(item: viewTitle, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)
        
    
        //ADD HOUSE BUTTON
        /*let addHouseButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        addHouseButton.backgroundColor = UIColor.whiteColor()
        addHouseButton.setTitle("ADD HOUSE", forState: UIControlState.Normal)
        addHouseButton.addTarget(self, action: "addHouseAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        addHouseButton.setTranslatesAutoresizingMaskIntoConstraints(false)*/
        //self.view.addSubview(addHouseButton)
            view.addSubview(usernameTF)
        let topAddHouseButton = NSLayoutConstraint(item: usernameTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: viewTitle, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:100)
        let centerAddHouseButton = NSLayoutConstraint(item: usernameTF, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)
        
        //LIST HOUSES BUTTON
        /*let listHouseButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        listHouseButton.backgroundColor = UIColor.whiteColor()
        listHouseButton.setTitle("LIST HOUSES", forState: UIControlState.Normal)
        listHouseButton.addTarget(self, action: "listHouseAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        listHouseButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(listHouseButton)*/
         view.addSubview(passwordTF)
        passwordTF.secureTextEntry = true
        let topListHouseButton = NSLayoutConstraint(item: passwordTF, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: usernameTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerListHouseButton = NSLayoutConstraint(item: passwordTF, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)
        
        //ADD REALTOR BUTTON
        let loginButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.setTitle("LOGIN", forState: UIControlState.Normal)
        loginButton.addTarget(self, action: "loginTouched:", forControlEvents: UIControlEvents.TouchUpInside)
        
        loginButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(loginButton)
        
        let topLoginButton = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: passwordTF, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerLoginButton = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)

        
        //SET ACTIVE CONSTRAINTS
        
         NSLayoutConstraint.activateConstraints([topAddHouseButton,centerAddHouseButton, topListHouseButton, centerListHouseButton, topLoginButton, centerLoginButton])
        
        /*NSLayoutConstraint.activateConstraints([topAddHouseButton,centerAddHouseButton, centerViewTitle, leadingViewTitle, centerViewTitle, topListHouseButton, centerListHouseButton, topAddRealtorButton, centerAddRealtorButton])*/

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginTouched(sender:UIButton!)
    {
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        self.testUsername = usernameTF.text
        performQuery()
        dispatch_after(time, dispatch_get_main_queue()) {
        if(self.passwordTF.text == self.testPassword) {
            self.presentViewController(AdminOptionsViewController(), animated: true, completion: nil)
        } else {
          
                let alert = UIAlertView()
                alert.title = "Try Again"
                alert.message = "Oops, incorrect password!"
                alert.addButtonWithTitle("Exit")
                alert.show()
                
            
        }
        }
    }
    
    func performQuery() {
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let usernamePredicate = NSPredicate(format: "Username = %@", self.testUsername)
        let query = CKQuery(recordType: "ADMIN", predicate: usernamePredicate)
        var string = NSMutableString()
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            }
            else {
                if(!results.isEmpty) {
                    let tr:CKRecord = results[0] as! CKRecord
                    self.testPassword = tr.valueForKey("Password") as! String
                    println(self.testPassword)

                } else {
                    self.testPassword = " "
                    println(self.testPassword)
                }
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                })
            }
        }
    }
    
}
