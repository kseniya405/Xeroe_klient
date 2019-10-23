//
//  resultAddressTableViewCell.swift
//  Xeroe
//
//  Created by Denis Markov on 10/8/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ResultAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!

    func setParameters(address: String) {
        addressLabel.text = address
    }
    
}
