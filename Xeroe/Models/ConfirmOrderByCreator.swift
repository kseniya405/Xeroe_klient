//
//  ConfirmOrderByCreator.swift
//  Xeroe
//
//  Created by Денис Марков on 8/13/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

var numProduct = 0

var orderData = ConfirmOrderByCreator(products: [Product()])

struct ConfirmOrderByCreator {
    let payment_method: String? = nil
    let delivery_type: Int? = 0
    let cost: Int? = 0
    var products: [Product]
}

struct Product {
    var id: Int? = 0
    var name: String? = nil
    var description: String? = nil
    var width: Int? = 0
    var height: Int? = 0
    var length: Int? = 0
    var weight: Int? = 0
}

