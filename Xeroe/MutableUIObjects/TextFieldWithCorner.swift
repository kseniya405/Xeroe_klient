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


}
