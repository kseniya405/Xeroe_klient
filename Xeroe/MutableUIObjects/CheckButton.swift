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
    var isChecked = false {
        didSet {
            let image = isChecked ? checkedImage : uncheckedImage
            self.setImage(image, for: UIControl.State.normal)
            self.imageView?.image = image
        }
    }
    
    var isLigament = false
    
    override func awakeFromNib() {
    }
    
    
    func setParametersImage(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
    }
    
    func setChecked(isChecked: Bool) {
        self.isChecked = isChecked
    }
}
