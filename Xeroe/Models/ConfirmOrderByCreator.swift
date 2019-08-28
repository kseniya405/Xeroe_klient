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
    
    let payment_method: String? = nil
    let delivery_type: Int? = 0
    let cost: Int? = 0
    var products = [Product()]
}

class Product {
    var id: Int? = 0
    var name: String? = nil
    var description: String? = nil
    var width: Int? = 0
    var height: Int? = 0
    var length: Int? = 0
    var weight: Int? = 0
}

