//
//  LeftMenuTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 7/31/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!{
        didSet {
            iconImage.layer.cornerRadius = 2
            iconImage.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var nameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    // change the contents of the cell and its color depending on whether the cell is selected
    func setData(nameCell: String, isSelected: Bool) {        
        self.nameCell.text = nameCell
        self.iconImage.image = UIImage(named: nameCell)?.withRenderingMode(.alwaysTemplate)
        
        let backgroundColor = isSelected ? backgroundChooseCellColor : .white
        let fillingColor = isSelected ? .white : blackTextColor
        chooseColors(nameCell, backgroundColor: backgroundColor, fillingColor: fillingColor)
    }
    
    func chooseColors(_ nameCell: String, backgroundColor: UIColor, fillingColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.iconImage.tintColor = fillingColor
        self.iconImage.backgroundColor = backgroundColor
        self.nameCell.textColor = fillingColor
    }

}
