//
//  OptionsTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: CheckButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkButton.setParametersImage(checkedImage: UIImage(named: "checkInsure"), uncheckedImage: UIImage(named: "uncheckInsure"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
