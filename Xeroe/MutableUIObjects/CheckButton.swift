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
    var checkedImage: UIImage?
    var uncheckedImage: UIImage?
    
    // Bool property
    var isChecked = true {
        didSet{
            let image = isChecked ? checkedImage : uncheckedImage
            self.setImage(image, for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = true
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    
    func setParametersImage(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        self.reloadInputViews()
    }
}
