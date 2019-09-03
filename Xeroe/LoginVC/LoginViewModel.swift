//
//  LoginViewModel.swift
//  Xeroe
//
//  Created by Denis Markov on 8/30/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    var setError: ((Bool, Bool) -> ())?
    
    var goToHomeScreen: (() -> ())?
    
    func validateTextFields(loginFormView: LoginFormView) -> Bool {
        
        let loginTextField = loginFormView.loginTextField
        let passwordTextField = loginFormView.passwordTextField
        
        guard let login = loginTextField?.text, let password = passwordTextField?.text, !login.isEmpty, !password.isEmpty else {
            
            let passwordIsEmpty = passwordTextField?.text?.isEmpty ?? true
            let emailIsEmpty = loginTextField?.text?.isEmpty ?? true
            
            setError?(passwordIsEmpty, emailIsEmpty)
            return false
        }
        return true
    }
    
    func login(loginFormView: LoginFormView) {
        
        let login = loginFormView.loginTextField.text ?? UserDefaults.standard.string(forKey: DefaultsKeys.login.rawValue)
        let password = loginFormView.passwordTextField.text ?? UserDefaults.standard.string(forKey: DefaultsKeys.password.rawValue)
        
        RestApi().login(login: login!, password: password!) { (isOk, token) in
            
            guard isOk, let token = token else {
                self.setError?(false, false)
                return
            }
            
            UserDefaults.standard.set(token, forKey: DefaultsKeys.token.rawValue)
            UserDefaults.standard.set(login, forKey: DefaultsKeys.login.rawValue)
            UserDefaults.standard.set(password, forKey: DefaultsKeys.password.rawValue)
            self.goToHomeScreen?()
            
            
        }
    }
    
    
}
