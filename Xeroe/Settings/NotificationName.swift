//
//  NotificationName.swift
//  Xeroe
//
//  Created by Денис Марков on 9/24/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

enum NotificationName: String {

    case notificationOpenOrCloseSideMenu = "notificationOpenOrCloseSideMenu"
    case notificationCloseSideMenu = "notificationCloseSideMenu"
    case notificationCloseSideMenuWithoutAnimation = "notificationCloseSideMenuWithoutAnimation"

    var notification : Notification.Name  {
        return Notification.Name(rawValue: self.rawValue )
    }
}
