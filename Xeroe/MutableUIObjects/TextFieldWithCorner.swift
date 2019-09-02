//
//  TextFieldWithCorner.swift
//  Xeroe
//
//  Created by Денис Марков on 8/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class TextFieldWithCorner: UITextField {

    override func awakeFromNib() {
        self.layer.borderColor = borderTextFieldColor.cgColor
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.textColor = blackTextColor
        self.font = UIFont(name: robotoMedium, size: 12)
    }
    
    func errorInput(isError: Bool) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = isError ? 2.0 : 0.0
        self.layer.borderColor = redBorder.cgColor
    }

}
