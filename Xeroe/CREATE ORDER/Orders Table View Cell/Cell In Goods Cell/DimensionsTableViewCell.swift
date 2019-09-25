//
//  DimensionsTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/13/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol DimensionsTableViewCellDelegate {
    func setWidthDeliver(width: Int?)
    func setLengthDeliver(length: Int?)
    func setHeightDeliver(height: Int?)
    func setWeightDeliver(weight: Int?)
}

class DimensionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var widthTextField: TextFieldWithCorner! {
        didSet {
            widthTextField.addTarget(self, action: #selector(widthTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    @IBOutlet weak var lengthTextField: TextFieldWithCorner!{
        didSet {
            lengthTextField.addTarget(self, action: #selector(lengthTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    @IBOutlet weak var heightTextField: TextFieldWithCorner!{
        didSet {
            heightTextField.addTarget(self, action: #selector(heightTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    @IBOutlet weak var weightTextField: TextFieldWithCorner!{
        didSet {
            weightTextField.addTarget(self, action: #selector(weightTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    
    var delegate: DimensionsTableViewCellDelegate?
    
    @objc func widthTextFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.filter{ $0.isNumber }
        if let text = textField.text, let data = Int(text) {
            delegate?.setWidthDeliver(width: data)
        }
    }
    
    @objc func lengthTextFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.filter{ $0.isNumber }
        if let text = textField.text, let data = Int(text) {
            delegate?.setLengthDeliver(length: data)
        }
    }
    
    @objc func heightTextFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.filter{ $0.isNumber }
        if let text = textField.text, let data = Int(text) {
            delegate?.setHeightDeliver(height: data)
        }
    }
    
    @objc func weightTextFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.filter{ $0.isNumber }
        if let text = textField.text, let data = Int(text) {
            delegate?.setWeightDeliver(weight: data)
        }
    }
    
    func sanitizeText(sourceText: String?) -> String? {
        guard let text = sourceText else { return nil }
        return text.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
    }
    
    func setParameters(width: String, length: String, height: String, weight: String)  {
        widthTextField.text = width
        lengthTextField.text = length
        heightTextField.text = height
        weightTextField.text = weight
    }
    
    override func prepareForReuse() {
        widthTextField.text = ""
        lengthTextField.text = ""
        heightTextField.text = ""
        weightTextField.text = ""
    }
}
