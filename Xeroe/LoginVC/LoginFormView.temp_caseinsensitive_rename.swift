//
//  loginFormView.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LoginFormView: UIView {
    
    @IBOutlet weak var loginTextField: TextFieldWithCorner! {
        didSet {
            loginTextField.addTarget(self, action: #selector(changeColorBorderTextField(_:)), for: UIControl.Event.editingDidBegin)
            loginTextField.addTarget(self, action: #selector(unchangeColorBorderTextField(_:)), for: UIControl.Event.editingDidEnd)
        }
    }
    
    @IBOutlet weak var passwordTextField: TextFieldWithCorner! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(changeColorBorderTextField(_:)), for: UIControl.Event.editingDidBegin)
            passwordTextField.addTarget(self, action: #selector(unchangeColorBorderTextField(_:)), for: UIControl.Event.editingDidEnd)
        }
    }
    
    @IBOutlet weak var enterEmailLabel: UILabel! {
        didSet {
            enterEmailLabel.setLabelStyle(textLabel: enterEmail, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: errorColor)
        }
    }
    
    @IBOutlet weak var enterPasswordLabel: UILabel! {
        didSet {
            enterPasswordLabel.setLabelStyle(textLabel: enterPassword, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: errorColor)
        }
    }
    
    @IBOutlet weak var wrongPaswordLabel: UILabel!{
        didSet {
            wrongPaswordLabel.setLabelStyle(textLabel: wrongPassword, fontLabel: UIFont(name: robotoRegular, size: 11), colorLabel: errorColor)
        }
    }
    
    
    @IBOutlet weak var visibilityPasswordButton: ButtonWithCornerRadius! {
        didSet {
            visibilityPasswordButton.addTarget(self, action: #selector(visibilityPasswordButtonTap), for: .touchUpInside)
        }
    }
    
    @objc func visibilityPasswordButtonTap() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageButton = passwordTextField.isSecureTextEntry ? #imageLiteral(resourceName: "invisible") : #imageLiteral(resourceName: "visible")
        visibilityPasswordButton.setImage(imageButton, for: .normal)
    }
    
    @objc func changeColorBorderTextField(_ textField: TextFieldWithCorner) {
        self.enterEmailLabel.isHidden = true
        self.wrongPaswordLabel.isHidden = true
        self.enterPasswordLabel.isHidden = true
        textField.changeColor(isChabge: true)
    }
    
    @objc func unchangeColorBorderTextField(_ textField: TextFieldWithCorner) {
        textField.changeColor(isChabge: false)
    }

    
    func errorTextField(passwordIsEmpty: Bool, emailIsEmpty: Bool, emailIsWrong: Bool) {
        if emailIsEmpty || emailIsWrong {
            self.enterEmailLabel.isHidden = false
            self.enterEmailLabel.text = emailIsEmpty ? enterEmail : wrongEmail
        } else {
            self.wrongPaswordLabel.isHidden = passwordIsEmpty
        }
        self.enterPasswordLabel.isHidden = !passwordIsEmpty
    }
    
}
