//
//  ClientTableViewCell.swift
//  Xeroe
//
//  Created by Denis Markov on 10/11/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol ClientTableViewCellDelegate {
    func editName(inputName: String, isSender: Bool)
    func editNumber(inputNumber: String)
}

class ClientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.setLabelStyle(textLabel: requestPassword, fontLabel: UIFont(name: robotoMedium, size: 18), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var nameTextField: TextFieldWithCorner!  {
        didSet {
            nameTextField.font = UIFont(name: robotoRegular, size: 17)
            nameTextField.textColor = blackTextColor
            nameTextField.addTarget(self, action: #selector(nameEditingChanged), for: .editingChanged)
        }
    }
    @IBOutlet weak var provideNameLabel: UILabel! {
        didSet{
            provideNameLabel.setLabelStyle(textLabel: provideName, fontLabel: UIFont(name: robotoRegular, size: sizeFontError), colorLabel: errorColor)
        }
    }
    @IBOutlet weak var addressTextField: TextFieldWithCorner! {
        didSet{
            addressTextField.isUserInteractionEnabled = false
            addressTextField.backgroundColor = lightGrayBackgroundColor
            addressTextField.font = UIFont(name: robotoRegular, size: 17)
            addressTextField.textColor = lightGrayTextColor
            addressTextField.layer.borderColor = lightGrayTextColor.cgColor
        }
    }
    @IBOutlet weak var mobileNumberTextField: TextFieldWithCorner!  {
        didSet{
            //               mobileNumberTextField.isUserInteractionEnabled = false
            mobileNumberTextField.backgroundColor = lightGrayBackgroundColor
            mobileNumberTextField.font = UIFont(name: robotoRegular, size: 17)
            mobileNumberTextField.addTarget(self, action: #selector(mobileNumberEditingChanged), for: .editingChanged)
        }
    }
    @IBOutlet weak var explanationOfNumber: UILabel! {
        didSet{
            explanationOfNumber.setLabelStyle(textLabel: explanationNumber, fontLabel: UIFont(name: robotoRegular, size: sizeFontError), colorLabel: lightGrayTextColor)
        }
    }
    @IBOutlet weak var provideMobileNumberLabel: UILabel! {
        didSet{
            provideMobileNumberLabel.setLabelStyle(textLabel: provideMobileNumber, fontLabel: UIFont(name: robotoRegular, size: sizeFontError), colorLabel: errorColor)
        }
    }
    
    var delegate: ClientTableViewCellDelegate?
    var isSender = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func mobileNumberEditingChanged() {
        provideMobileNumberLabel.isHidden = true
        delegate?.editNumber(inputNumber: mobileNumberTextField.text ?? "")
        
    }
    
    @objc func nameEditingChanged(){
        nameTextField.layer.borderColor = basicBlueColor.cgColor
        nameTextField.layer.borderWidth = 1
        provideNameLabel.isHidden = true
        delegate?.editName(inputName: nameTextField.text ?? "", isSender: isSender)
    }
    
    func setParameters(header: String, address: String, name: String, mobileNumber: String, isSender: Bool, errorName: Bool, errorMobileNumber: Bool) {
        self.isSender = isSender
        self.headerLabel.text = header
        self.addressTextField.text = address
        self.mobileNumberTextField.text = mobileNumber
        self.mobileNumberTextField.isUserInteractionEnabled = !isSender
        self.provideNameLabel.isHidden = !errorName
        self.nameTextField.text = name
        if isSender {
            self.mobileNumberTextField.backgroundColor = lightGrayBackgroundColor
            self.explanationOfNumber.isHidden = true
            self.provideMobileNumberLabel.isHidden = true
            self.mobileNumberTextField.textColor = lightGrayTextColor

        } else {
            self.mobileNumberTextField.backgroundColor = .white
            self.explanationOfNumber.isHidden = false
            self.provideMobileNumberLabel.isHidden = !errorMobileNumber
            mobileNumberTextField.textColor = blackTextColor
        }
    }

}
