//
//  DeliveryTypeCollectionViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/21/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class DeliveryTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoDeliveryType: UIImageView!
    @IBOutlet weak var deliveryType: UILabel!
    @IBOutlet weak var price: UILabel!
    
    struct deliveryData {
        let logoName: String
        let nameDelivery: String
        let priceDelivery: String
    }
    
    let arrayDelivery = [
        deliveryData(logoName: "bicycle", nameDelivery: "Bicycle", priceDelivery: "£ 1.80"),
        deliveryData(logoName: "car", nameDelivery: "Car", priceDelivery: "£ 3.80"),
        deliveryData(logoName: "van", nameDelivery: "Van", priceDelivery: "£ 1.80")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logoDeliveryType.layer.cornerRadius = logoDeliveryType.frame.height / 2.0
        logoDeliveryType.layer.borderWidth = 1
        logoDeliveryType.layer.masksToBounds = true
    }
    
    func defaultParameters(type: Int) {
        guard type < arrayDelivery.count else {
            return
        }
        logoDeliveryType.image = UIImage(named: arrayDelivery[type].logoName)
        logoDeliveryType.layer.borderColor = grayTextColor.cgColor
        logoDeliveryType.backgroundColor = .white

        deliveryType.text = arrayDelivery[type].nameDelivery
        price.text = arrayDelivery[type].priceDelivery
        
    }
}
