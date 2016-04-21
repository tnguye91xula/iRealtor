


import UIKit
import CloudKit

class AdminOptionsViewController: UIViewController {

    
    
    
  private var tbvc = UITabBarController()
     override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let viewTitle = UILabel()
        viewTitle.text = ""
        viewTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(viewTitle)
        
        let leadingViewTitle =  NSLayoutConstraint(item: viewTitle, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 10)
        let topViewTitle = NSLayoutConstraint(item: viewTitle, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 10)
        let centerViewTitle = NSLayoutConstraint(item: viewTitle, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)

        //ADD HOUSE BUTTON
        let addHouseButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        addHouseButton.backgroundColor = UIColor.whiteColor()
        addHouseButton.setTitle("ADD HOUSE", forState: UIControlState.Normal)
        addHouseButton.addTarget(self, action: "addHouseAction:", forControlEvents: UIControlEvents.TouchUpInside)

        addHouseButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(addHouseButton)
        
        let topAddHouseButton = NSLayoutConstraint(item: addHouseButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: viewTitle, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerAddHouseButton = NSLayoutConstraint(item: addHouseButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)
        
        //LIST HOUSES BUTTON
        let listHouseButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        listHouseButton.backgroundColor = UIColor.whiteColor()
        listHouseButton.setTitle("LIST HOUSES", forState: UIControlState.Normal)
        listHouseButton.addTarget(self, action: "listHouseAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        listHouseButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(listHouseButton)
        
        let topListHouseButton = NSLayoutConstraint(item: listHouseButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: addHouseButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerListHouseButton = NSLayoutConstraint(item: listHouseButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)
        
        //ADD REALTOR BUTTON
        let addRealtorButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        addRealtorButton.backgroundColor = UIColor.whiteColor()
        addRealtorButton.setTitle("ADD REALTOR", forState: UIControlState.Normal)
        addRealtorButton.addTarget(self, action: "addRealtorAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        addRealtorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(addRealtorButton)
        
        let topAddRealtorButton = NSLayoutConstraint(item: addRealtorButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: listHouseButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerAddRealtorButton = NSLayoutConstraint(item: addRealtorButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)
        
        //LIST HOUSES BUTTON
        let listRealtorButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        listRealtorButton.backgroundColor = UIColor.whiteColor()
        listRealtorButton.setTitle("LIST REALTORS", forState: UIControlState.Normal)
        listRealtorButton.addTarget(self, action: "listRealtorAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        listRealtorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(listRealtorButton)
        
        let topListRealtorButton = NSLayoutConstraint(item: listRealtorButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: addRealtorButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerListRealtorButton = NSLayoutConstraint(item: listRealtorButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)
        
        //LIST HOUSES BUTTON
        let logoutButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        logoutButton.backgroundColor = UIColor.whiteColor()
        logoutButton.setTitle("LOGOUT", forState: UIControlState.Normal)
        logoutButton.addTarget(self, action: "logoutAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        logoutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(logoutButton)
        
        let topLogoutButton = NSLayoutConstraint(item: logoutButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: listRealtorButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:10)
        let centerLogoutButton = NSLayoutConstraint(item: logoutButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:10)


        //SET ACTIVE CONSTRAINTS
        
        NSLayoutConstraint.activateConstraints([topAddHouseButton,centerAddHouseButton, centerViewTitle, leadingViewTitle, centerViewTitle, topListHouseButton, centerListHouseButton, topAddRealtorButton, centerAddRealtorButton, topListRealtorButton, centerListRealtorButton, topLogoutButton, centerLogoutButton])


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addHouseAction(sender:UIButton!) {
        self.presentViewController(AddHouseViewController(), animated: true, completion: nil)

    }
    
    func listHouseAction(sender:UIButton!) {
        self.presentViewController(AdminAvailableHouseViewController(), animated: true, completion: nil)
        
    }
    
    func addRealtorAction(sender:UIButton!) {
        self.presentViewController(AddRealtorViewController(), animated: true, completion: nil)
        
    }
    
    func listRealtorAction(sender:UIButton!) {
        self.presentViewController(AdminListRealtorsViewController(), animated: true, completion: nil)
        
    }
    
    func logoutAction(sender:UIButton!) {
        self.presentViewController(LoginViewController(), animated: true, completion: nil)
        
    }


}