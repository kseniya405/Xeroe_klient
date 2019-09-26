//
//  TextFieldWithCorner.swift
//  Xeroe
//
//  Created by Денис Марков on 8/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class TextFieldWithCorner: UITextField {
    
    var leftInsets: CGFloat = 5.0
    var padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    var fontSize = 12

    override func awakeFromNib() {
        self.layer.borderColor = borderTextFieldColor.cgColor
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.textColor = blackTextColor
        self.font = UIFont(name: robotoMedium, size: CGFloat(fontSize))

    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        padding.left = leftInsets
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        padding.left = leftInsets
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        padding.left = leftInsets
        return bounds.inset(by: padding)
    }
    
    func errorInput(isError: Bool) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = isError ? 2.0 : 0.0
        self.layer.borderColor = redBorder.cgColor
    }
    
}
