//
//  File.swift
//  Xeroe
//
//  Created by Денис Марков on 8/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

class RestApi {
    
    func login(login: String, password: String, callback: @escaping (Bool, String?) -> Void) {
        
        let jsonUrlString = "http://xeroe.kinect.pro:8091/api/auth/login"
        guard let url = URL(string: jsonUrlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["username" : login, "password" : password]
        //create the session object
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: []) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create dataTask using the session object to send data to the server
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil, let data = data else {
                print("Error: \(String(describing: error))")
                callback(false, nil)
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    if let token = json["access_token"] as? String {
                        callback(true, token)
                    } else {
                        callback(false, nil)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func findID(xeroeID: String, callback: @escaping (Bool, String?) -> Void) {

        guard let url = URL(string: "http://xeroe.kinect.pro:8091/api/client/find/8ceb?") else { return }
        
        let token  = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC94ZXJvZS5raW5lY3QucHJvOjgwOTFcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE1NjUxMDAxMTgsImV4cCI6MTU2NTE4NjUxOCwibmJmIjoxNTY1MTAwMTE4LCJqdGkiOiJWSHZ0TmZnc1dZdUszZUZGIiwic3ViIjoxLCJwcnYiOiIxM2U4ZDAyOGIzOTFmM2I3YjYzZjIxOTMzZGJhZDQ1OGZmMjEwNzJlIiwic2NvcGVzIjpbImNsaWVudCJdfQ.sAiX8TH4xgqN5zbs5D4lBemkKvbZPKBGbNleNYxNvGE"
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "Authorization")
//        request.setValue(xeroeID, forHTTPHeaderField: "xeroeID")

        //create dataTask using the session object to send data to the server
        _ = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                callback(false, nil)
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    print(json)
                }
            } catch let error {
                print("error JSONSerialization: \(error.localizedDescription)")
            }
        }).resume()
    }
        
        
        
        
//        let headers: HTTPHeaders = ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC94ZXJvZS5raW5lY3QucHJvOjgwOTFcL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE1NjUxMDAxMTgsImV4cCI6MTU2NTE4NjUxOCwibmJmIjoxNTY1MTAwMTE4LCJqdGkiOiJWSHZ0TmZnc1dZdUszZUZGIiwic3ViIjoxLCJwcnYiOiIxM2U4ZDAyOGIzOTFmM2I3YjYzZjIxOTMzZGJhZDQ1OGZmMjEwNzJlIiwic2NvcGVzIjpbImNsaWVudCJdfQ.sAiX8TH4xgqN5zbs5D4lBemkKvbZPKBGbNleNYxNvGE"]
//        
//        Alamofire.request("http://xeroe.kinect.pro:8091/api/client/find/\(xeroeID)", method: .get, parameters: ["xeroeID" : xeroeID], encoding: JSONEncoding.default, headers: headers).responseJSON {
//            response in
//            
//            guard response.result.isSuccess, let _ = response.result.value as? [String:Any] else{
//                print("Error: \(String(describing: response.result.error))")
//                callback(false, nil)
//                return
//            }
//            print("OK: \(String(describing: response.result.value)))")
//            
//        }
//        
//        
//    }
}