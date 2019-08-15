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
    
    func setParameters(isSender: Bool) -> Void {
        self.IDLabel.text = isSender ? "ID: # RD 27B86" : "ID: # CM 14C12"
        self.nameLabel.text = isSender ? "Sandra Lee" : "Andy McMillian"
        self.phoneLabel.text = isSender ? "+44 888 88 88" : "+44 555 55 55"
        self.addressLabel.text = isSender ? "27 Old Gloucester Street, London WC1N" : "11 - 59 Hight Rd, East Finchley, London N2 8AW"
        let nameImage = isSender ? "userPhoto" : "clientPhoto"
        self.photoImage.image = UIImage(named: nameImage)
    }


}
