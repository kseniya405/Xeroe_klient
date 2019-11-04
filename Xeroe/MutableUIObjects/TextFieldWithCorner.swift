//
//  TextFieldWithCorner.swift
//  Xeroe
//
//  Created by Денис Марков on 8/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let textFieldCornerRadius: CGFloat = 4


class TextFieldWithCorner: UITextField {
    
    var leftInsets: CGFloat = 5.0
    var padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.borderColor = borderTextFieldColor.cgColor
        self.layer.cornerRadius = textFieldCornerRadius
        self.layer.borderWidth = 1.0
        self.textColor = blackTextColor
        self.font = UIFont(name: robotoRegular, size: sizeFontBasic)
        self.addTarget(self, action: #selector(setSelected), for: .editingDidBegin)
        self.addTarget(self, action: #selector(setDeselected), for: .editingDidEnd)
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
    
    @objc func setSelected() {
        self.layer.borderColor = basicBlueColor.cgColor
    }
    
    @objc func setDeselected() {
        self.layer.borderColor = borderTextFieldColor.cgColor
    }

    
    func validateEmail() -> Bool {
        let enteredEmail = self.text
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        debugPrint(emailPredicate.evaluate(with: enteredEmail))
        return emailPredicate.evaluate(with: enteredEmail)
     }
    
}
