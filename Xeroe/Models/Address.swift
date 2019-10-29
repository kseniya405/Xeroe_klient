//
//  DataClientID.swift
//  Xeroe
//
//  Created by Денис Марков on 8/14/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Address: NSCoder, CLLocationManagerDelegate {
    
    static var shared = Address()
    
    var collection : CLLocationCoordinate2D?  {
        set {
            UserDefaults.standard.set(newValue, forKey: "collection")
            UserDefaults.standard.synchronize()
        }
        get {
            if let collection = UserDefaults.standard.object(forKey: "collection") {
                return collection as? CLLocationCoordinate2D
            }
            return nil
        }
    }
    
    var delivery : CLLocationCoordinate2D?  {
        set {
            UserDefaults.standard.set(newValue, forKey: "delivery")
            UserDefaults.standard.synchronize()
        }
        get {
            if let delivery = UserDefaults.standard.object(forKey: "delivery") {
                return delivery as? CLLocationCoordinate2D
            }
            return nil
        }
    }
}
