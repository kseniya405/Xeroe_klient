//
//  DataDeliveryTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol DataDeliveryTableViewCellDelegate {
    func setDataDeliveryName(name: String)
    func setDataDeliveryDescription(description: String)
}

class DataDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var questionsLabel: UILabel!
    
    @IBOutlet weak var answerTextView: UITextView! {
        didSet {
            self.layer.masksToBounds = true
            self.layer.borderColor = borderTextFieldColor.cgColor
            self.layer.cornerRadius = 4
            self.fontSize = 12
            self.translatesAutoresizingMaskIntoConstraints = false
            answerTextView.target(forAction: #selector(textFieldDidChange(_:)), withSender: UIControl.Event.editingChanged)
        }
    }
    
    var delegate: DataDeliveryTableViewCellDelegate?
        
    var fontSize = 12

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("work")
        guard let data = textField.text else { return }
        if questionsLabel.text == nameDeliver {
            delegate?.setDataDeliveryName(name: data)
        } else {
            delegate?.setDataDeliveryDescription(description: data)
        }
    }
    
    func setParameters(questionsLabel: String, answerText: String) {
        self.questionsLabel.text = questionsLabel
        self.answerTextView.text = answerText
    }

}


