//
//  ParcelSizeTypeCollectionViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/16/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ParcelSizeTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var typeSizeImageView: UIImageView!
    @IBOutlet weak var typeSizeLabel: UILabel! {
        didSet {
         typeSizeLabel.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: .darkText)
        }
    }
    
    func setParameters(imageName: String, typeSize: String) {
        self.typeSizeImageView.image = UIImage(named: imageName)
        self.typeSizeLabel.text = typeSize
    }

}
