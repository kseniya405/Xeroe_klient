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
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    func errorInput(isError: Bool) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = isError ? 2.0 : 0.0
        self.layer.borderColor = UIColor(red: 1, green: 0, blue:00, alpha: 1.0).cgColor
    }

}
