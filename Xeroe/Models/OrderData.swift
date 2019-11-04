//
//  OrderData.swift
//  Xeroe
//
//  Created by Денис Марков on 10/15/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class OrderData {
    
    var collectionData = userData()
    var deliveryData = userData()
    var parselDetails = ""
    var parcelSize: Int? = nil
    var parcelValue: Int? = 0
    var photo: UIImage? = nil
    var isChecked = false
    var route: MKRoute?
    
    func clearInputData() {
        collectionData.name = nil
        collectionData.mobileNumber = nil
        deliveryData.name = nil
        deliveryData.mobileNumber = nil
        parselDetails = ""
        parcelSize = nil
        parcelValue = 0
        photo = nil
        isChecked = false
    }
}


class userData {
    var name: String? = nil
    var address: String? = nil
    var mobileNumber: String? = nil
    var coordinate: CLLocationCoordinate2D? = nil
}
