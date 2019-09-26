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

        guard let url = URL(string: "http://xeroe.kinect.pro:8091/api/auth/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = ["username" : login, "password" : password]
        //create the session object
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: []) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        //create dataTask using the session object to send data to the server
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil, let data = data else {
                debugPrint("Error: \(String(describing: error))")
                callback(false, nil)
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    debugPrint(json)
                    if let token = json["access_token"] as? String {
                        callback(true, token)
                    } else {
                        callback(false, nil)
                    }
                }
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func findID(xeroeID: String, callback: @escaping (Bool, [String: Any]) -> Void) {
        
        guard let url = URL(string: "http://xeroe.kinect.pro:8091/api/client/find/\(xeroeID)") else { return }
        
        let token  = "Bearer \(UserDefaults.standard.string(forKey: DefaultsKeys.token.rawValue) ?? ""))"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        //create dataTask using the session object to send data to the server
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else {
                debugPrint("Error: \(String(describing: error))")
                callback(false, [:])
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    guard json.count > 0, let _ = json[0]["avatar"] as? String else {
                        callback(false, [:])
                        return
                    }
                    callback(true, json[0])
                    return
                }
                
            } catch let error {
                debugPrint("error JSONSerialization: \(error.localizedDescription)")
                callback(false, [:])
                return
            }
        }).resume()
    }
    
    func clientData (callback: @escaping (Bool, String?) -> Void) {

        guard let url = URL(string: "http://xeroe.kinect.pro:8091/api/client/") else { return }

        let token  = "Bearer \(UserDefaults.standard.string(forKey: DefaultsKeys.token.rawValue) ?? ""))"

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        //        request.setValue(xeroeID, forHTTPHeaderField: "xeroeID")

        //create dataTask using the session object to send data to the server
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else {
                debugPrint("Error: \(String(describing: error))")
                callback(false, nil)
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    guard let xeroeid = json["xeroeid"] as? String else {
                        callback(false, nil)
                        return
                    }
                    callback(true, xeroeid)
                    return
                }

            } catch let error {
                debugPrint("error JSONSerialization: \(error.localizedDescription)")
                callback(false, nil)
            }
        }).resume()
    }
    
    func createOrder(idClient: Int, callback: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://xeroe.kinect.pro:8091/api/client/order/") else { return }
        let token  = "Bearer \(UserDefaults.standard.string(forKey: DefaultsKeys.token.rawValue) ?? ""))"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = ["sender_id" : idClient, "recipient_id" : 5]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: []) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        //create dataTask using the session object to send data to the server
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            debugPrint("start URLSession")
            
            guard let data = data else {
                debugPrint("Error: \(String(describing: error))")
                callback(false)
                return
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? String {

                    debugPrint("json" + json)
                    callback(true)
                    return
                } else {
                    debugPrint("errorParsingJSON")
                }
                
            } catch let error {
                callback(false)
                debugPrint("error JSONSerialization: \(error.localizedDescription)")
            }
        }).resume()
    }
    
}
