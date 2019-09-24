//
//  UILabel.swift
//  Xeroe
//
//  Created by Денис Марков on 9/24/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    /**
     sets label parameters and style
     */
    func setLabelStyle(textLabel: String? = nil, fontLabel: UIFont?, colorLabel: UIColor?) {
        if let textLabel = textLabel {
            self.text = textLabel
        }
        self.font = fontLabel
        self.textColor = colorLabel
    }
}
