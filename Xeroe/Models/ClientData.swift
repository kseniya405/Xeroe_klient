//
//  DataClientID.swift
//  Xeroe
//
//  Created by Денис Марков on 8/14/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

//struct ArrayClientData: Codable {
//    let arrayClient: [ClientData]
//}

struct ClientData: Codable {
    let id: Int
    let xeroeId: String
    let defaultAddressId: Int
    let email: String
    let phone: String
    let password: String
    let state: String
    let avatar: String
    let userableType: String
    let userableId: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case xeroeId
        case defaultAddressId
        case email
        case phone
        case password
        case state
        case avatar
        case userableType
        case userableId
        case createdAt
        case updatedAt
    }
    
//    init(dictionary: [String : Any]?) {
//        id = dictionary?["id"] as? Int ?? 0
//        xeroeId = dictionary?["xeroeid"] as? String ?? ""
//        defaultAddressId = dictionary?["default_address_id"] as? Int ?? 0
//        email = dictionary?["email"] as? String ?? ""
//        phone = dictionary?["phone"] as? String ?? ""
//        password = dictionary?["password"] as? String ?? ""
//        state = dictionary?["state"] as? String ?? ""
//        avatar = dictionary?["avatar"] as? String ?? ""
//        userableType = dictionary?["userable_type"] as? String ?? ""
//        userableId = dictionary?["userable_id"] as? Int ?? 0
//        createdAt = dictionary?["created_at"] as? String ?? ""
//        updatedAt = dictionary?["updated_at"] as? String ?? ""
//    }
}
