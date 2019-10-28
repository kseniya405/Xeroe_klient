//
//  ParcelValueTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/18/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol ParcelValueDelegate {
    func setParcelValue(value: Int)
}

class ParcelValueTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!{
        didSet {
            headerLabel.setLabelStyle(textLabel: parcelValue, fontLabel: UIFont(name: robotoMedium, size: 18), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var valueTextField: UITextField! {
        didSet {
            valueTextField.font = UIFont(name: robotoRegular, size: 17)
            valueTextField.textColor = blackTextColor
            valueTextField.addTarget(self, action: #selector(valueEditingChanged), for: .editingChanged)
        }
    }
    @IBOutlet weak var provideValueLabel: UILabel! {
        didSet{
            provideValueLabel.setLabelStyle(textLabel: provideValue, fontLabel: UIFont(name: robotoRegular, size: sizeFontError), colorLabel: errorColor)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var delegate: ParcelValueDelegate?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func valueEditingChanged(){
        valueTextField.layer.borderColor = basicBlueColor.cgColor
        provideValueLabel.isHidden = true
        valueTextField.text = valueTextField.text?.filter{ $0.isNumber }
        if let text = valueTextField.text, let value = Int(text) {
            delegate?.setParcelValue(value: value)
        }
    }
    
    func setParameters(value: Int?) {
        provideValueLabel.isHidden = true
        if let intValue = value {
            valueTextField.text = intValue == 0 ? "" : String(intValue)
        }
    }
    
    func errorValue(showError: Bool) {
        if showError {
            provideValueLabel.isHidden = false
        }
    }
}
