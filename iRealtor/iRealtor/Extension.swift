import Foundation
import UIKit

extension UITextField {
    class func createUITextField(backGroundColor: CGColor, autoSizingContraint: Bool) -> UITextField {
        var textField = UITextField()
        textField.layer.backgroundColor = backGroundColor
        textField.clearButtonMode = .WhileEditing
        textField.layer.borderColor = UIColor.grayColor().CGColor
        textField.layer.borderWidth = 0.0
        textField.layer.cornerRadius = 3
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 2.0
        textField.layer.shadowColor = UIColor.blackColor().CGColor
        textField.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.setTranslatesAutoresizingMaskIntoConstraints(autoSizingContraint)
        return textField
    }
}

extension UILabel {
    class func createUILabel(text: String, autoSizingContraint: Bool) -> UILabel {
        var label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.setTranslatesAutoresizingMaskIntoConstraints(autoSizingContraint)
        return label
    }
}