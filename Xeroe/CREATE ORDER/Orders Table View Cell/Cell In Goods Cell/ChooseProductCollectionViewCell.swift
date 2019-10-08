//
//  AddProductCollectionViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ChooseProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelCell: UILabel!
    
    func setParameters(backgroundColor: UIColor? = nil, labelColor: UIColor? = nil, labelText: String? = nil) {
        self.contentView.backgroundColor = backgroundColor
        self.labelCell.textColor = labelColor
        self.labelCell.text = labelText
    }
    
    func defaultParameters(labelText: String){
        self.contentView.backgroundColor = productCellOrderTableBackgroundColor
        self.labelCell.textColor = productCellOrderTableTextColor
        self.labelCell.text = labelText
    }
}