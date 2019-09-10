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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setParameters(textNamesLabel: String) {
        namesLabel.text = textNamesLabel
    }
    
    override func prepareForReuse() {
        namesLabel.text = ""
        answerTextField.text = ""
    }
}
