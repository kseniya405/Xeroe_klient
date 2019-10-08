//
//  RegistrationTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol RegistrationCellDelegate {
    func cellIsEmpty(isEmpty: Bool, numCell: Int?)
}

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
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var visibleButton: UIButton!{
        didSet {
            visibleButton.addTarget(self, action: #selector(visibleButtonTap), for: .touchUpInside)
        }
    }
    
    var delegate: RegistrationCellDelegate?
    var numCell: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @objc func answerTextFieldDidChange(_ textField: TextFieldWithCorner) {
        textField.changeColor(isChabge: true)
        pleaseEnterDataLable.isHidden = true
        spaceView.isHidden = false
        let cellIsEmpty = textField.text?.isEmpty ?? true
        delegate?.cellIsEmpty(isEmpty: cellIsEmpty, numCell: numCell)
    }
    
    @objc func answerTextFieldDidEnd(_ textField: TextFieldWithCorner) {
        textField.changeColor(isChabge: false)
        let cellIsEmpty = textField.text?.isEmpty ?? true
        delegate?.cellIsEmpty(isEmpty: cellIsEmpty, numCell: numCell)
    }
    
    @objc func visibleButtonTap() {
        answerTextField.isSecureTextEntry.toggle()
        let imageButton = answerTextField.isSecureTextEntry ? #imageLiteral(resourceName: "invisible") : #imageLiteral(resourceName: "visible")
        visibleButton.setImage(imageButton, for: .normal)
    }
    
    func setParameters(placeholder: String, errorText: String) {
        answerTextField.placeholder = placeholder
        pleaseEnterDataLable.text = errorText
    }
    
    
}
