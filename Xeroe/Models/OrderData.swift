//
//  OrderData.swift
//  Xeroe
//
//  Created by Денис Марков on 10/15/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

class OrderData {
    
    var collectionData = userData()
    var deliveryData = userData()
    var parselDetails = ""
    var parselSize = typeSize.self
    var parcelValue: Int? = 0
    var photo: UIImage? = nil
    
    enum typeSize {
        case envelopeS
        case envelopeM
        case envelopeL
        case packageS
        case packageM
        case packageL
        case bulkyItemL
        case bulkyItemXl
    }
}


class userData {
    var name: String? = nil
    var address: String? = nil
    var mobileNumber: String? = nil
}
