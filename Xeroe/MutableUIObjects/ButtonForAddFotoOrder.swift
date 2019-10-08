//
//  ButtonForAddFotoOrder.swift
//  Xeroe
//
//  Created by Денис Марков on 8/9/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let buttonCornerRadius: CGFloat = 4
fileprivate let buttonBorderWidth: CGFloat = 2

class ButtonForAddFotoOrder: UIButton {
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = buttonCornerRadius
        self.layer.borderWidth = buttonBorderWidth
        self.layer.borderColor = borderTextFieldColor.cgColor
    }
}
