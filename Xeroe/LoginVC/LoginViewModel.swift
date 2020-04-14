//
//  LoginViewModel.swift
//  Xeroe
//
//  Created by Denis Markov on 8/30/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    var setError: ((Bool, Bool, Bool) -> ())?
    
    var goToHomeScreen: (() -> ())?
    
    /**
     Accepts the View with the Username and password textField And authorizes with the entered data.
        If successful - opens HomeViewController
        If failure - informs the user about it
     */
    func login(loginFormView: LoginFormView) {
        
        guard let loginTextField = loginFormView.loginTextField, let passwordTextField = loginFormView.passwordTextField else {
            return
        }
        
        guard let login = loginTextField.text, let password = passwordTextField.text, !login.isEmpty, !password.isEmpty, loginTextField.validateEmail() else {
            
            let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true
            let emailIsEmpty = loginTextField.text?.isEmpty ?? true
            let emailIsWrong = emailIsEmpty ? false : !loginTextField.validateEmail()
            
            setError?(passwordIsEmpty, emailIsEmpty, emailIsWrong)
            return
        }
        
        //hardcoded
        if login ==  "example@gmail.com", password == "password" {
            UserProfile.shared.token = "token"
            UserProfile.shared.password = "password"
            UserProfile.shared.login = login
            goToHomeScreen?()
        }
        
        
//        RestApi().login(login: login, password: password) { (isOk, token) in
//
//            guard isOk, let token = token else {
//                self.setError?(false, false, false)
//                return
//            }
//
//            UserProfile.shared.login = login
//            UserProfile.shared.token = token
//            UserProfile.shared.password = password
//
//            self.setUserData { (isOk) in
//                self.goToHomeScreen?()
//            }
//        }
    }
    
    
    /**
     Gets the user's XeroeID, and it receives the rest of the user’s data.
    */
    func setUserData(callback: @escaping (Bool) -> Void)  {
        
        let hardCodedUserData: [String : Any] = [DefaultsKeys.id.rawValue : 1,
                                                 DefaultsKeys.xeroeId.rawValue : "8ceb",
                                                 DefaultsKeys.defaultAddressId.rawValue : 1,
                                                 DefaultsKeys.email.rawValue : "example@gmail.com",
                                                 DefaultsKeys.phone.rawValue : "+380669962666",
                                                 DefaultsKeys.state.rawValue : "client",
                                                 DefaultsKeys.avatar.rawValue : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fru.pngtree.com%2Ffreepng%2F520-couple-avatar-boy-avatar-little-dinosaur-cartoon-cute_4561296.html&psig=AOvVaw3R_a72j1Fo-eHGMBOyrwt2&ust=1584632449847000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCNjH5IWupOgCFQAAAAAdAAAAABAE",
                                                 DefaultsKeys.userableType.rawValue : "client",
                                                 DefaultsKeys.userableId.rawValue : 1]
        
        self.setUserProfile(hardCodedUserData)
        UserProfile.shared.printProfile()
        callback(true)
//        RestApi().clientData() { (isOk, xeroeid)  in
//            DispatchQueue.main.async {
//                guard isOk, let userXeroeID = xeroeid else {
//                    debugPrint("AAAAA! Something in RestApi().clientData() wrong. isOk: \(isOk), xeroeid: \(String(describing: xeroeid))")
//                    callback(false)
//                    return
//                }
//
//                RestApi().findID(xeroeID: userXeroeID) { (isOk, dictionaryClientData)  in
//                    DispatchQueue.main.async {
//                        guard isOk else {
//                            callback(false)
//                            return
//                        }
//                        self.setUserProfile(dictionaryClientData)
//                        UserProfile.shared.printProfile()
//                        callback(true)
//                    }
//                }
//            }
//        }
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
