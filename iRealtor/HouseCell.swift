import Foundation
import UIKit

class HouseCell: UITableViewCell {
    var nameLabel: UILabel!
    var addressLabel: UILabel!
    var imagView: UIImageView!
    var house: HouseInfo? {
        didSet {
            if let h = house {
                nameLabel.backgroundColor = UIColor.whiteColor()
                nameLabel.text = h.name
                nameLabel.numberOfLines = 0
                addressLabel.backgroundColor = UIColor.whiteColor()
                addressLabel.text = h.address
                addressLabel.numberOfLines = 0
                imagView.image = h.image
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        imagView = UIImageView(frame: CGRectZero)
        contentView.addSubview(imagView)
        
        nameLabel = UILabel(frame: CGRectZero)
        nameLabel.textColor = UIColor.blackColor()
        contentView.addSubview(nameLabel)
        
        addressLabel = UILabel(frame: CGRectZero)
        addressLabel.textColor = UIColor.blackColor()
        contentView.addSubview(addressLabel)
        
        imagView.setTranslatesAutoresizingMaskIntoConstraints(false)
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let t1 =  NSLayoutConstraint(item: imagView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 5)
        
        let leading1 =  NSLayoutConstraint(item: imagView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 5)
        
        let trailing1 =  NSLayoutConstraint(item: imagView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        let bottom1 =  NSLayoutConstraint(item: imagView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5)
        
        let t =  NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 10)
        
        let leading =  NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 5)
        
        let top = NSLayoutConstraint(item: addressLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: nameLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let leadingAddress =  NSLayoutConstraint(item: addressLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: nameLabel, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        let trailingAddress =  NSLayoutConstraint(item: addressLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activateConstraints([t, leading, top, leadingAddress, t1, leading1, trailing1, bottom1, trailingAddress])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}