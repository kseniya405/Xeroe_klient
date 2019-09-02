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

    

    
    func setData(nameCell: String, selected: Bool) {
        self.nameCell.text = nameCell
        iconImage.image = UIImage(named: nameCell)?.withRenderingMode(.alwaysTemplate)
        if selected {
            chooseColors(nameCell, backgroundColor: backgroundChooseCellColor, fillingColor: .white)
        } else {
            chooseColors(nameCell, backgroundColor: .white, fillingColor: blackTextColor)
        }
    }
    
    func chooseColors(_ nameCell: String, backgroundColor: UIColor, fillingColor: UIColor) {
        self.backgroundColor = backgroundColor
        iconImage.image = UIImage(named: nameCell)?.withRenderingMode(.alwaysTemplate)
        iconImage.tintColor = fillingColor
        iconImage.backgroundColor = backgroundColor
        self.nameCell.textColor = fillingColor
    }
    
}
