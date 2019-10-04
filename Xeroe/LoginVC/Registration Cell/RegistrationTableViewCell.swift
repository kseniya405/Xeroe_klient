//
//  RegistrationTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class RegistrationTableViewCell: UITableViewCell {

    @IBOutlet weak var answerTextField: TextFieldWithCorner! {
        didSet {
            answerTextField.addTarget(self, action: #selector(answerTextFieldDidChange(_:)), for: .editingChanged)
            answerTextField.addTarget(self, action: #selector(answerTextFieldDidEnd(_:)), for: .editingDidEnd)
        }
    }
    
    @IBOutlet weak var pleaseEnterDataLable: UILabel! {
        didSet {
            pleaseEnterDataLable.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: errorColor)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @objc func answerTextFieldDidChange(_ textField: TextFieldWithCorner) {
        textField.changeColor(isChabge: true)
        pleaseEnterDataLable.isHidden = true
    }
    
    @objc func answerTextFieldDidEnd(_ textField: TextFieldWithCorner) {
        textField.changeColor(isChabge: false)
    }
    
    func setParameters(placeholder: String, errorText: String) {
        answerTextField.placeholder = placeholder
        pleaseEnterDataLable.text = errorText
    }
    
    
}
