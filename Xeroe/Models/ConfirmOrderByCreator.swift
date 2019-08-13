//
//  ConfirmOrderByCreator.swift
//  Xeroe
//
//  Created by Денис Марков on 8/13/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

struct ConfirmOrderByCreator {
    let payment_method: String
    let delivery_type: Int
    let cost: Int
    let products: [Product]
    let dictionary: [String: Any]
    
    init(payment_method: String, delivery_type: Int, cost: Int, products: [Product]) {
        self.payment_method = payment_method
        self.delivery_type = delivery_type
        self.cost = cost
        self.products = products
        self.dictionary = ["payment_method" : payment_method, "delivery_type" : delivery_type, "cost" : cost, "products" : products]
    }
    
}

struct Product {
    let id: Int
    let name: String
    let description: String
    let width: Int
    let height: Int
    let length: Int
    let weight: Int
    
//    init(id: Int, name: String, description: String, width: Int, height: Int, length: Int, weight: Int) {
//        self.id = id
//        self.name = name
//        self.description = name
//        self.width = width
//        self.height = height
//        self.length = length
//        self.weight = weight
//    }
}

