//
//  DataDeliveryTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class DataDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var questionsLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        answerTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setParameters(questionsLabel: String) {
        self.questionsLabel.text = questionsLabel
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        ConfirmOrderByCreator.orderData.products[ConfirmOrderByCreator.orderData.numProduct].name = textField.text
    }
}


