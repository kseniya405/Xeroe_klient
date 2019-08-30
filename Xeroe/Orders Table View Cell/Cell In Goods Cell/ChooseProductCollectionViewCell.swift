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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setParameters(backgroundColor: UIColor? = nil, labelColor: UIColor? = nil, labelText: String? = nil) {
        self.contentView.backgroundColor = backgroundColor
        self.labelCell.textColor = labelColor
        self.labelCell.text = labelText
    }
    
    func defaultParameters(){
        self.contentView.backgroundColor = .black
        self.labelCell.textColor = .white
    }
}
