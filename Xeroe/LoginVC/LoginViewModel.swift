//
//  LoginViewModel.swift
//  Xeroe
//
//  Created by Denis Markov on 8/30/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    var setError: ((UITextField, Bool) -> ())?
    
    var goToHomeScreen: (() -> ())?
    
    func validateTextFields(textField: UITextField) {
        setError?(textField, textField.text?.isEmpty ?? true)
    }
    
    func login(login: String, password: String) {
        RestApi().login(login: login, password: password) { (isOk, token) in
            guard isOk, let token = token else {
                //                    self.errorTextFieldPassword(passwordIsEmpty: false, emailIsEmpty: false)
                
                return
            }
            UserDefaults.standard.set(token, forKey: "token")
            UserDefaults.standard.set(login, forKey: "login")
            UserDefaults.standard.set(password, forKey: "password")
            self.goToHomeScreen?()
        }
    }
}
