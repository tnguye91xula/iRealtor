import Foundation
import UIKit

class RealtorCell: UITableViewCell {
    var nameLabel: UILabel!
    var companyLabel: UILabel!
    var realtor: RealtorInfo? {
        didSet {
            if let r = realtor {
                nameLabel.backgroundColor = UIColor.whiteColor()
                nameLabel.text = r.firstName! + " " + r.lastName!
                nameLabel.numberOfLines = 0
                companyLabel.backgroundColor = UIColor.whiteColor()
                companyLabel.text = r.company
                companyLabel.numberOfLines = 0
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        nameLabel = UILabel(frame: CGRectZero)
        nameLabel.textColor = UIColor.blackColor()
        contentView.addSubview(nameLabel)
        
        companyLabel = UILabel(frame: CGRectZero)
        companyLabel.textColor = UIColor.blackColor()
        contentView.addSubview(companyLabel)
        
    
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        companyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        let t =  NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20)
        
        let leading =  NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: -50)
        
        let top = NSLayoutConstraint(item: companyLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: nameLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        
        let leadingAddress =  NSLayoutConstraint(item: companyLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: nameLabel, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        let trailingAddress =  NSLayoutConstraint(item: companyLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activateConstraints([t, leading, top, leadingAddress, trailingAddress])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}