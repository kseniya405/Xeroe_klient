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
    var showAlertInputButtonTap: (() -> ())?
    
    var goToLoginScreen: (() -> ())?

    func findUser (xeroeIDTextField: TextFieldWithCorner) {
        
    
        guard var textID = xeroeIDTextField.text, !textID.isEmpty, !textID.contains(" ") else {
            showAlertInputButtonTap?()
            return
        }

        textID.remove(at: textID.startIndex)
        RestApi().findID(xeroeID: textID) { (isOk, dictionaryClientData)  in
            DispatchQueue.main.async {
                guard isOk else {
                    self.showAlertInputButtonTap?()
                    return 
                }
                self.goToNextScreen?(dictionaryClientData)
            }
        }
        return

    }
    
    /** Checks the relevance of the token.
             - If relevant - opens the HomeViewController.
             - If not relevant: re-authorized with previously entered username and password.
     Successfully - opens the HomeViewController.
     Not successful - leaves the user on LoginViewController and clear UserProfile.shared
     */
    func tokenValidation() {
        RestApi().clientData() { (isOk, xeroeid)  in
            DispatchQueue.main.async {
                guard isOk, let _ = xeroeid else {
                    print("Token is not relevant. isOk: \(isOk), xeroeid: \(String(describing: xeroeid)). Re-authorized ...")
                    
                    guard let login = UserProfile.shared.login, let password = UserProfile.shared.password else {
                        print("Login or password does not exist. Login: \(String(describing: UserProfile.shared.login)), password: \(String(describing: UserProfile.shared.password))")
                        self.goToLoginScreen?()
                        return
                    }
                    
                    RestApi().login(login: login, password: password) { (isOk, token) in
                        DispatchQueue.main.async {
                            guard isOk, let token = token else {
                                print("Wrong current login or password. Login: \(login), password: \(String(describing: password))")
                                UserProfile.shared.clear()
                                self.goToLoginScreen?()
                                return
                            }
                            UserProfile.shared.token = token
                        }
                    }
                    return
                }
                return
            }
        }
    }
}

