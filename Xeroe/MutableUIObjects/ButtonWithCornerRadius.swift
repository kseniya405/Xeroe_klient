//
//  ButtonWithCornerRadius.swift
//  Xeroe
//
//  Created by Денис Марков on 8/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ButtonWithCornerRadius: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
    }
    
    func setParameters(text: String, font: UIFont?, tintColor: UIColor, backgroundColor: UIColor) {
        self.setTitle(text, for: .normal)
        self.tintColor = tintColor
        if let textFont = font {
            self.titleLabel?.font = textFont
        }
        self.backgroundColor = backgroundColor
    }

}
