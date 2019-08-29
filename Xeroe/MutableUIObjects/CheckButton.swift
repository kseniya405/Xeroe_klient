//
//  RadioButton.swift
//  Xeroe
//
//  Created by Денис Марков on 8/13/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class CheckButton: UIButton {
    // Images
    var checkedImage = UIImage(named: "checkedImage")! as UIImage
    var uncheckedImage = UIImage(named: "uncheckedImage")! as UIImage
    
    // Bool property
    var isChecked = true {
        didSet{
            let image = isChecked ? checkedImage : uncheckedImage
            self.setImage(image, for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
