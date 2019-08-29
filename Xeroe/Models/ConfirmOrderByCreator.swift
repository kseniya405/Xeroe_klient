//
//  ConfirmOrderByCreator.swift
//  Xeroe
//
//  Created by Денис Марков on 8/13/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

class ConfirmOrderByCreator {
    
    var numProduct = 0
    
    static var orderData = ConfirmOrderByCreator()
    
    var payment_method: String? = nil
    var delivery_type: Int? = 0
    var cost: Int? = 0
    var products = [Product()]
    
    
//    var productDict: [[String : Any]]?
//    var asDictionary: [String : Any]?
    
//    init() {
//        for i in 0...products.count - 1 {
//            productDict.append(products[i].dictionary)
//        }
//        asDictionary = ["payment_method": payment_method as Any,
//                        "delivery_type": delivery_type as Any,
//                        "cost": 0,
//                        "products": [productDict]
//        ]
//
//    }
}

class Product: Codable {
    var id: Int? = 0
    var name: String? = nil
    var description: String? = nil
    var width: Int = 1
    var height: Int = 1
    var length: Int = 1
    var weight: Int = 1
//    var dictionary: [String : Any]?
//
//    init() {
//        dictionary =  ["id": id as Any,
//                       "name": name as Any,
//                       "description": description as Any,
//                       "width": width as Any,
//                       "height": height as Any,
//                       "length": length as Any,
//                       "weight": weight as Any]
//    }
}



