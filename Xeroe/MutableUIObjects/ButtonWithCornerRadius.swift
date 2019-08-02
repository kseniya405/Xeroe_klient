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
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
    }

}
