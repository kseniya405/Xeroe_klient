//
//  UserData.swift
//  Xeroe
//
//  Created by Денис Марков on 8/14/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

// Sets / gets / keeps all client data in UserDefaults
class UserProfile {
    
    static var shared = UserProfile()
    
    var token : String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.token.rawValue)
            print("set token")
            UserDefaults.standard.synchronize()
        }
        get {
            if let token = UserDefaults.standard.string(forKey: DefaultsKeys.token.rawValue) {
                return token
            }
            return nil
        }
    }
    
    var login : String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.login.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let login = UserDefaults.standard.string(forKey: DefaultsKeys.login.rawValue) {
                return login
            }
            return nil
        }
    }
    
    var password : String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.password.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let password = UserDefaults.standard.string(forKey: DefaultsKeys.password.rawValue) {
                return password
            }
            return nil
        }
    }
    
    var id : Int?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.id.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let id = UserDefaults.standard.string(forKey: DefaultsKeys.id.rawValue) {
                return convertStringToInt(string: id)
            }
            return nil
        }
    }
    
    var xeroeId: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.xeroeId.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let xeroeId = UserDefaults.standard.string(forKey: DefaultsKeys.xeroeId.rawValue) {
                return xeroeId
            }
            return nil
        }
    }
    
    var defaultAddressId: Int?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.defaultAddressId.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let defaultAddressId = UserDefaults.standard.string(forKey: DefaultsKeys.defaultAddressId.rawValue) {
                return convertStringToInt(string: defaultAddressId)
            }
            return nil
        }
    }
    
    var email: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.email.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let email = UserDefaults.standard.string(forKey: DefaultsKeys.email.rawValue) {
                return email
            }
            return nil
        }
    }
    
    var phone: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.phone.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let phone = UserDefaults.standard.string(forKey: DefaultsKeys.phone.rawValue) {
                return phone
            }
            return nil
        }
    }
    
    var state: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.state.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let state = UserDefaults.standard.string(forKey: DefaultsKeys.state.rawValue) {
                return state
            }
            return nil
        }
    }
    
    var avatar: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.avatar.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let avatar = UserDefaults.standard.string(forKey: DefaultsKeys.avatar.rawValue) {
                return avatar
            }
            return nil
        }
    }
    
    var userableType: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.userableType.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let userableType = UserDefaults.standard.string(forKey: DefaultsKeys.userableType.rawValue) {
                return userableType
            }
            return nil
        }
    }
    
    var userableId: Int?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.userableId.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let userableId = UserDefaults.standard.string(forKey: DefaultsKeys.userableId.rawValue) {
                return convertStringToInt(string: userableId)
            }
            return nil
        }
    }

    func clear(callback: @escaping (Bool) -> Void) {

        login = nil
        token = nil
        id = nil
        xeroeId = nil
        defaultAddressId = nil
        email = nil
        phone = nil
        password = nil
        state = nil
        avatar = nil
        userableType = nil
        userableId = nil
        UserDefaults.standard.synchronize()
        callback(true)
    }
    
    func printProfile(){
        print("token: \(String(describing: token))\n login: \(String(describing: login))\n password: \(String(describing: password))\n id: \(String(describing: id))\n xeroeId: \(String(describing: xeroeId)) defaultAddressId: \(String(describing: defaultAddressId))\n email: \(String(describing: email))\n phone: \(String(describing: phone))\n state: \(String(describing: state))\n avatar: \(String(describing: avatar))\n userableType: \(String(describing: userableType))\n userableId: \(String(describing: userableId))")
    }
    
    func convertStringToInt(string: String) -> Int {
        let intInString = string.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
        return Int(intInString) ?? 0
    }
    
}

