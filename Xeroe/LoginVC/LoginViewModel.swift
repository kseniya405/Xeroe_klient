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
    
    /**
     Accepts the View with the Username and password textField And authorizes with the entered data.
        If successful - opens HomeViewController
        If failure - informs the user about it
     */
    func login(loginFormView: LoginFormView) {
        
        let loginTextField = loginFormView.loginTextField
        let passwordTextField = loginFormView.passwordTextField
        
        guard let login = loginTextField?.text, let password = passwordTextField?.text, !login.isEmpty, !password.isEmpty else {
            
            let passwordIsEmpty = passwordTextField?.text?.isEmpty ?? true
            let emailIsEmpty = loginTextField?.text?.isEmpty ?? true
            
            setError?(passwordIsEmpty, emailIsEmpty)
            return
        }
        
        RestApi().login(login: login, password: password) { (isOk, token) in
            
            guard isOk, let token = token else {
                self.setError?(false, false)
                return
            }
            
            UserProfile.shared.login = login
            UserProfile.shared.token = token
            UserProfile.shared.password = password
            
            self.setUserData { (isOk) in
                self.goToHomeScreen?()
            }
        }
    }
    
    
    /**
     Gets the user's XeroeID, and it receives the rest of the user’s data.
    */
    func setUserData(callback: @escaping (Bool) -> Void)  {
        RestApi().clientData() { (isOk, xeroeid)  in
            DispatchQueue.main.async {
                guard isOk, let userXeroeID = xeroeid else {
                    debugPrint("AAAAA! Something in RestApi().clientData() wrong. isOk: \(isOk), xeroeid: \(String(describing: xeroeid))")
                    callback(false)
                    return
                }
                                
                RestApi().findID(xeroeID: userXeroeID) { (isOk, dictionaryClientData)  in
                    DispatchQueue.main.async {
                        guard isOk else {
                            callback(false)
                            return
                        }
                        self.setUserProfile(dictionaryClientData)
                        UserProfile.shared.printProfile()
                        callback(true)
                    }
                }
            }
        }
    }
    
    /**
     fills UserProfile.share
     */
    func setUserProfile(_ dictionary: [String: Any]) {
        UserProfile.shared.id = dictionary[DefaultsKeys.id.rawValue] as? Int
        UserProfile.shared.xeroeId  = dictionary[DefaultsKeys.xeroeId.rawValue] as? String
        UserProfile.shared.defaultAddressId = dictionary[DefaultsKeys.defaultAddressId.rawValue] as? Int
        UserProfile.shared.email = dictionary[DefaultsKeys.email.rawValue] as? String
        UserProfile.shared.phone = dictionary[DefaultsKeys.phone.rawValue] as? String
        UserProfile.shared.state = dictionary[DefaultsKeys.state.rawValue] as? String
        UserProfile.shared.avatar = dictionary[DefaultsKeys.avatar.rawValue] as? String
        UserProfile.shared.userableType = dictionary[DefaultsKeys.userableType.rawValue] as? String
        UserProfile.shared.userableId = dictionary[DefaultsKeys.userableId.rawValue] as? Int
    }

    
}
