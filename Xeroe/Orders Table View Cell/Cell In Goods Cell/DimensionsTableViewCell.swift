//
//  DimensionsTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/13/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class DimensionsTableViewCell: UITableViewCell {

    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        lengthTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        heightTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let data = sanitizeText(sourceText: textField.text)
        switch textField {
        case widthTextField:
            ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].width = Int(data ?? "") ?? 1
        case lengthTextField:
            ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].length = Int(data ?? "") ?? 1
        case heightTextField:
            ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].height = Int(data ?? "") ?? 1
        case weightTextField:
            ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].weight = Int(data ?? "") ?? 1
        default:
            return
        }
        
    }
    
    func sanitizeText(sourceText: String?) -> String? {
        guard let text = sourceText else { return nil }
        return text.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
    }
    
    func setParameters()  {
       widthTextField.text = String(ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].width)
       lengthTextField.text = String(ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].length)
       heightTextField.text = String(ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].height)
       weightTextField.text = String(ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].weight)
    }
}
