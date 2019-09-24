//
//  ProblemHeaderTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 9/20/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ProblemHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var problemValue: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
