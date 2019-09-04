//
//  DataClientID.swift
//  Xeroe
//
//  Created by Денис Марков on 8/14/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

struct ArrayClientData: Codable {
    let arrayClient: [ClientData]
}

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
    let userableId: String
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(xeroeId, forKey: .xeroeId)
        try container.encode(defaultAddressId, forKey: .defaultAddressId)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(password, forKey: .password)
        try container.encode(state, forKey: .state)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(userableType, forKey: .userableType)
        try container.encode(userableId, forKey: .userableId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        xeroeId = try container.decode(String.self, forKey: .xeroeId)
        defaultAddressId = try container.decode(Int.self, forKey: .defaultAddressId)
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
        password = try container.decode(String.self, forKey: .password)
        state = try container.decode(String.self, forKey: .state)
        avatar = try container.decode(String.self, forKey: .avatar)
        userableType = try container.decode(String.self, forKey: .userableType)
        userableId = try container.decode(String.self, forKey: .userableId)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
}
