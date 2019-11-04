//
//  HomeViewModel.swift
//  Xeroe
//
//  Created by Денис Марков on 9/3/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel: NSObject {
    var goToNextScreen: (([String : Any]) -> ())?
    var showAlertInputButtonTap: ((String) -> ())?
    
    var goToLoginScreen: (() -> ())?
    
    
    /** Checks the relevance of the token.
             - If relevant - opens the HomeViewController.
             - If not relevant: re-authorized with previously entered username and password.
     Successfully - opens the HomeViewController.
     Not successful - leaves the user on LoginViewController and clear UserProfile.shared
     */
    func tokenValidation() {
        RestApi().clientData() { (isOk, xeroeid)  in
            guard isOk, let _ = xeroeid else {
                debugPrint("Token is not relevant. isOk: \(isOk), xeroeid: \(String(describing: xeroeid)). Re-authorized ...")
                
                guard let login = UserProfile.shared.login, let password = UserProfile.shared.password else {
                    debugPrint("Login or password does not exist. Login: \(String(describing: UserProfile.shared.login)), password: \(String(describing: UserProfile.shared.password))")
                    self.goToLoginScreen?()
                    return
                }
                
                RestApi().login(login: login, password: password) { (isOk, token) in
                    guard isOk, let token = token else {
                        debugPrint("Wrong current login or password. Login: \(login), password: \(String(describing: password))")
                        UserProfile.shared.clear(callback: { (isOk) in
                            self.goToLoginScreen?()
                        })
                        return
                    }
                    UserProfile.shared.token = token
                }
                return
            }
            return
        }
    }
}

