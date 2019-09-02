//
//  loginFormView.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class loginFormView: UIView {
    
    @IBOutlet weak var loginTextField: TextFieldWithCorner!
    @IBOutlet weak var passwordTextField: TextFieldWithCorner!
    @IBOutlet weak var enterEmailLabel: UILabel! {
        didSet {
            enterEmailLabel.text = enterEmail
        }
    }
    
    @IBOutlet weak var enterPasswordLabel: UILabel! {
        didSet {
            enterPasswordLabel.text = enterPassword
        }
    }
    
    @IBOutlet weak var wrongPaswordLabel: UILabel!{
        didSet {
            wrongPaswordLabel.text = wrongPassword
        }
    }
    
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.text = password
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
