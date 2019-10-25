//
//  DeliveryDataTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/25/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class DeliveryDataTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var value0Lable: UILabel!
    @IBOutlet weak var value1Lable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setParameters(title: String, value0: String?, value1: String?) {
        self.titleLable.text = title
        self.value0Lable.text = value0
        if let value = value1 {
            value1Lable.text = value
        } else {
            value1Lable.isHidden = true
        }
    }
    
}
