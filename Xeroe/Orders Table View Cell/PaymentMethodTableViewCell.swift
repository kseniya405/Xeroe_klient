//
//  PaymentMethodTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol PaymentMethodTableViewCellDelegate {
    func setPaymentMethod(isCreditCard: Bool)
}

class PaymentMethodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonImage: CheckButton!
    @IBOutlet weak var getInsuredLabel: UILabel!
    @IBOutlet weak var inputTextLabel: UILabel!
    
    var delegate: PaymentMethodTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonImage.setParametersImage(checkedImage: UIImage(named: "checkedImage"), uncheckedImage: UIImage(named: "uncheckedImage"))
        delegate?.setPaymentMethod(isCreditCard: buttonImage.isChecked)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
