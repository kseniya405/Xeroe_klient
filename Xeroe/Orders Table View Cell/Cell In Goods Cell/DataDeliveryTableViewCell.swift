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
    @IBOutlet weak var answerTextField: TextFieldWithCorner!
    
    var delegate: DataDeliveryTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        answerTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setParameters(questionsLabel: String, answerText: String) {
        self.questionsLabel.text = questionsLabel
        self.answerTextField.text = answerText
    }
        
    @objc func textFieldDidChange(_ textField: UITextField) {
        if questionsLabel.text == nameDeliver {
            delegate?.setDataDeliveryName(name: textField.text ?? "")
        } else {
            delegate?.setDataDeliveryDescription(description: textField.text ?? "")
        }
    }
}


