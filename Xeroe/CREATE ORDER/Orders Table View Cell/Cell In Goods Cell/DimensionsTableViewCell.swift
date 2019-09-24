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
    
    @IBOutlet weak var widthTextField: TextFieldWithCorner!
    @IBOutlet weak var lengthTextField: TextFieldWithCorner!
    @IBOutlet weak var heightTextField: TextFieldWithCorner!
    @IBOutlet weak var weightTextField: TextFieldWithCorner!
    
    var delegate: DimensionsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthTextField.addTarget(self, action: #selector(widthTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        lengthTextField.addTarget(self, action: #selector(lengthTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        heightTextField.addTarget(self, action: #selector(heightTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        weightTextField.addTarget(self, action: #selector(weightTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func widthTextFieldDidChange(_ textField: UITextField) {
        
        let data = Int(sanitizeText(sourceText: textField.text) ?? "1")
        delegate?.setWidthDeliver(width: data)
    }
    
    @objc func lengthTextFieldDidChange(_ textField: UITextField) {
        
        let data = Int(sanitizeText(sourceText: textField.text) ?? "1")
        delegate?.setLengthDeliver(length: data)
    }
    
    @objc func heightTextFieldDidChange(_ textField: UITextField) {
        let data = Int(sanitizeText(sourceText: textField.text) ?? "1")
        delegate?.setHeightDeliver(height: data)
    }
    
    @objc func weightTextFieldDidChange(_ textField: UITextField) {
        let data = Int(sanitizeText(sourceText: textField.text) ?? "1")
        delegate?.setWeightDeliver(weight: data)
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
