//
//  SenderTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ClientDataTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImage.layer.cornerRadius = photoImage.frame.height / 2.0
        photoImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
