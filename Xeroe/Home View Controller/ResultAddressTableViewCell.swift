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
    @IBOutlet weak var subtitleAddressLabel: UILabel!
    
    func setParameters(title: String, subtitle: String) {
        addressLabel.text = title
        subtitleAddressLabel.text = subtitle
    }
    
}
