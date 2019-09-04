//
//  ConfirmOrderByCreator.swift
//  Xeroe
//
//  Created by Денис Марков on 8/13/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

class ConfirmOrderByCreator: Codable {

    var payment_method: String? = nil
    var delivery_type: Int? = 0
    var cost: Int? = 0
    var products = [Product()]
}

class Product: Codable {
    var id: Int = 0
    var name: String? = nil
    var description: String? = nil
    var width: Int = 1
    var height: Int = 1
    var length: Int = 1
    var weight: Int = 1
}



