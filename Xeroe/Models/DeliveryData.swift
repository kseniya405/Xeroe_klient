//
//  DeliveryDate.swift
//  Xeroe
//
//  Created by Денис Марков on 10/24/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

struct DeliveryJson: Codable {
    var deliveries: [DeliveryData]?
}

struct DeliveryData: Codable {
    var number: Int?
    var status: String?
    var collectedName: String?
    var collectedAddress: String?
    var deliveryName: String?
    var deliveryAddress: String?
    var cost: String?
    var date: String?
    var payment: Int?
}


