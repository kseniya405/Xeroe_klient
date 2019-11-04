//
//  PaymentDetailsTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/21/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class PaymentDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.setLabelStyle(textLabel: paymentDetails, fontLabel: UIFont(name: robotoMedium, size: 18), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var paymentSystemLabel: UILabel! {
        didSet {
            paymentSystemLabel.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: 17), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var cardNumberLabel: UILabel!{
        didSet {
            cardNumberLabel.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: 17), colorLabel: .darkText)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setParameters(paymentSystem: String? = nil, endCardNumber: String? = nil) {
        if let numCard = endCardNumber, let payment = paymentSystem {
            paymentSystemLabel.text = payment
            cardNumberLabel.text = "**** **** **** " + numCard
            return
        }
        cardNumberLabel.text = "****"
        paymentSystemLabel.text = ""
    }
}
