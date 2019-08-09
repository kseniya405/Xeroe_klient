//
//  ButtonForAddFotoOrder.swift
//  Xeroe
//
//  Created by Денис Марков on 8/9/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ButtonForAddFotoOrder: UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
}
