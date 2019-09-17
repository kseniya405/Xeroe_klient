//
//  loginFormView.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LoginFormView: UIView {
    
    @IBOutlet weak var loginTextField: TextFieldWithCorner!
    @IBOutlet weak var passwordTextField: TextFieldWithCorner!
    
    @IBOutlet weak var enterEmailOrPhoneLabel: UILabel! {
        didSet {
            enterEmailOrPhoneLabel.setLabelStyle(textLabel: emailOrPhone, fontLabel: UIFont(name: robotoRegular, size: 13), colorLabel: greyTextColor)
        }
    }
    
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.setLabelStyle(textLabel: password, fontLabel: UIFont(name: robotoRegular, size: 13), colorLabel: greyTextColor)
        }
    }
    
    @IBOutlet weak var enterEmailLabel: UILabel! {
        didSet {
            enterEmailLabel.setLabelStyle(textLabel: enterEmail, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: .red)
        }
    }
    
    @IBOutlet weak var enterPasswordLabel: UILabel! {
        didSet {
            enterPasswordLabel.setLabelStyle(textLabel: enterPassword, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: .red)
        }
    }
    
    @IBOutlet weak var wrongPaswordLabel: UILabel!{
        didSet {
            wrongPaswordLabel.setLabelStyle(textLabel: wrongPassword, fontLabel: UIFont(name: robotoRegular, size: 11), colorLabel: .red)
        }
    }
    
    
    @IBOutlet weak var visibilityPasswordButton: ButtonWithCornerRadius! {
        didSet {
            visibilityPasswordButton.addTarget(self, action: #selector(visibilityPasswordButtonTap), for: .touchUpInside)
        }
    }
    
    @objc func visibilityPasswordButtonTap(){
        passwordTextField.isSecureTextEntry.toggle()
        let imageButtonName = passwordTextField.isSecureTextEntry ? "invisible" : "visible"
        visibilityPasswordButton.setImage(UIImage(named: imageButtonName), for: .normal)
    }
    
    func errorTextField(passwordIsEmpty: Bool, emailIsEmpty: Bool) {
        self.passwordTextField.errorInput(isError: true)
        self.loginTextField.errorInput(isError: emailIsEmpty)
        
        self.enterEmailLabel.isHidden = !emailIsEmpty
        self.wrongPaswordLabel.isHidden = passwordIsEmpty
        self.enterPasswordLabel.isHidden = !passwordIsEmpty
    }

}
