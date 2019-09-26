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

fileprivate let fontSize = 12

class DataDeliveryTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var questionsLabel: UILabel!
    
    @IBOutlet weak var answerTextView: UITextView! {
        didSet {
            answerTextView.layer.masksToBounds = true
            answerTextView.layer.borderColor = borderTextFieldColor.cgColor
            answerTextView.layer.borderWidth = 1
            answerTextView.layer.cornerRadius = 4
            answerTextView.font = UIFont(name: robotoRegular, size: CGFloat(fontSize))
            answerTextView.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
    var delegate: DataDeliveryTableViewCellDelegate?
    
    override func awakeFromNib() {
        answerTextView.delegate = self
    }

    
    func setParameters(questionsLabel: String, answerText: String) {
        self.questionsLabel.text = questionsLabel
        self.answerTextView.text = answerText
    }

    
    func textViewDidEndEditing(_ textView: UITextView) {
            guard let data = textView.text else { return }
            if questionsLabel.text == nameDeliver {
                delegate?.setDataDeliveryName(name: data)
            } else {
                delegate?.setDataDeliveryDescription(description: data)
            }
    }

}


