//
//  PaymentMethodTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonImage: CheckButton!
    @IBOutlet weak var getInsuredLabel: UILabel!
    @IBOutlet weak var inputTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
