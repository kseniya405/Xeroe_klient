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
        didSet {
            let image = isChecked ? checkedImage : uncheckedImage
            self.setImage(image, for: UIControl.State.normal)
        }
    }
    
    var isLigament = false
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked), for: UIControl.Event.touchUpInside)
    }
    
    @objc func buttonClicked() {
        isChecked = isLigament ? true : !isChecked
 
    }
    
    func setParametersImage(checkedImage: UIImage?, uncheckedImage: UIImage?, isLigament: Bool? = false) {
        self.isLigament = isLigament ?? false
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        self.reloadInputViews()
    }
    
    func setChecked(isChecked: Bool) {
        self.isChecked = isChecked
    }
}
