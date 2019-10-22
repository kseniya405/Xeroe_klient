//
//  UserData.swift
//  Xeroe
//
//  Created by Денис Марков on 8/14/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

// Sets / gets / keeps all client data in UserDefaults
class UserProfile: NSCoder {
    
    static var shared = UserProfile()
    
    var token : String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.token.rawValue)
            debugPrint("set token")
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
            let id = UserDefaults.standard.integer(forKey: DefaultsKeys.id.rawValue)
            return id == 0 ? nil : id
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
            let defaultAddressId = UserDefaults.standard.integer(forKey: DefaultsKeys.defaultAddressId.rawValue)
            return defaultAddressId == 0 ? nil : defaultAddressId
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
            let userableId = UserDefaults.standard.integer(forKey: DefaultsKeys.userableId.rawValue)
            return userableId == 0 ? nil : userableId
        }
    }

    
    var endCardNumber: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.endCardNumber.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let endCardNumber = UserDefaults.standard.string(forKey: DefaultsKeys.endCardNumber.rawValue) {
                return endCardNumber
            }
            return "• • • •"
        }
    }

    var valideDate: String?  {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultsKeys.valideDate.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            if let valideDate = UserDefaults.standard.string(forKey: DefaultsKeys.valideDate.rawValue) {
                return valideDate
            }
            return "MM/YY"
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
        debugPrint("token: \(String(describing: token))\n login: \(String(describing: login))\n password: \(String(describing: password))\n id: \(String(describing: id))\n xeroeId: \(String(describing: xeroeId)) defaultAddressId: \(String(describing: defaultAddressId))\n email: \(String(describing: email))\n phone: \(String(describing: phone))\n state: \(String(describing: state))\n avatar: \(String(describing: avatar))\n userableType: \(String(describing: userableType))\n userableId: \(String(describing: userableId))")
    }

}

