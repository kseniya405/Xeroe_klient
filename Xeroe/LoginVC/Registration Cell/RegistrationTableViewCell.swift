//
//  RegistrationTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class RegistrationTableViewCell: UITableViewCell {

    @IBOutlet weak var namesLabel: UILabel!
    
    @IBOutlet weak var answerTextField: TextFieldWithCorner!
    
    @IBOutlet weak var backgroundViewForHeight: UIView!
    
    @IBOutlet weak var heightCell: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setParameters(height: CGFloat, textNamesLabel: String) {
        heightCell.constant = height
        namesLabel.text = textNamesLabel
    }
    
}
