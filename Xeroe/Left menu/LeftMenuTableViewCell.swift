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


    // change the contents of the cell and its color depending on whether the cell is selected
    func setData(nameCell: String, isSelected: Bool) {        
        self.nameCell.text = nameCell
        self.iconImage.image = UIImage(named: nameCell)?.withRenderingMode(.alwaysTemplate)
        let fillingColor = isSelected ? UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1) : blackTextColor
        chooseColors(nameCell, fillingColor: fillingColor)
    }
    
    func chooseColors(_ nameCell: String, fillingColor: UIColor) {
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
        self.iconImage.tintColor = fillingColor
        self.iconImage.backgroundColor = .white
        self.nameCell.textColor = fillingColor
    }

}
