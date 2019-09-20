//
//  ProblemHeaderTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 9/20/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ProblemHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var problemValue: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        arrowImage.image = arrowImage.image?.rotate(radians: .pi)
    }
    
}
