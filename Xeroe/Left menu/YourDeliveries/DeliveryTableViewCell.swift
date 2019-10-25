//
//  deliveryTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/24/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {


    
    @IBOutlet var numDelivery: UILabel!
    @IBOutlet var deliveryDate: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var collectionAddress: UILabel!
    @IBOutlet var deliveryAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setParameters(data: DeliveryData) {
        
        numDelivery.text = "#" + String(data.number)
        deliveryDate.text = formatedDate(dateString: data.date )
        price.text = "£" + (data.cost )
        collectionAddress.text = data.collectedAddress
        deliveryAddress.text = data.deliveryAddress
    }
    
    func formatedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss"
        dateFormatter.locale = Locale.init(identifier: "en_GB")

        let dateObj = dateFormatter.date(from: dateString)

        dateFormatter.dateFormat = "dd-MM-yyyy"
        if let dateObj = dateObj {
            return dateFormatter.string(from: dateObj)
        }
        return ""
    }
    

}
