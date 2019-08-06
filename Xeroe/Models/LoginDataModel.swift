//
//  File.swift
//  Xeroe
//
//  Created by Денис Марков on 8/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import Alamofire

    struct LoginDataModel {
        var dict: [String: String]?
        var defaults = UserDefaults.standard
        
        init(_ usernameInput: String, _ passwordInput: String) {
            dict = ["username" : usernameInput, "password" : passwordInput]
            defaults.set(dict, forKey: "data")
        }
    }

class RestApi {
    
    func login(login: String, password: String, callback: @escaping (Bool, String?) -> Void) {
        Alamofire.request("http://xeroe.kinect.pro:8091/api/auth/login", method: .post, parameters: LoginDataModel(login, password).dict).responseJSON { response in
            guard response.result.isSuccess, let newsResponse = response.result.value as? [String:Any] else{
                print("Error: \(String(describing: response.result.error))")
                callback(false, nil)
                return
            }
            if let token = newsResponse["access_token"] as? String {
                callback(true, token)
            } else {
                callback(false, nil)
            }
            
        }
    }
    
    func findID(xeroeID: String, callback: @escaping (Bool, String?) -> Void) {
 
//        var headers: HTTPHeaders = [
//            "Authorization": "bearer \(String(describing: userData.userData.access_token))",
//            "Accept": "application/json"
//        ]
        Alamofire.request("http://xeroe.kinect.pro:8091/api/client/find/\(xeroeID)", method: .get, parameters: ["xeroeID" : xeroeID], encoding: JSONEncoding.default, headers: ["Authorization" : userData.userData.access_token!]).validate().responseJSON {
            response in

            guard response.result.isSuccess, let _ = response.result.value as? [String:Any] else{
                print("Error: \(String(describing: response.result.error))")
                callback(false, nil)
                return
            }
            print("OK: \(String(describing: response.result.value)))")

        }
        
        
    }
}
