//
//  LimitedSizeTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/16/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LimitedSizeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameSizeLabel: UILabel! {
           didSet {
               nameSizeLabel.setLabelStyle(fontLabel: UIFont(name: robotoMedium, size: 14), colorLabel: .darkText)
           }
       }
    @IBOutlet weak var valueSizeLabel: UILabel! {
              didSet {
                  valueSizeLabel.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: .darkText)
              }
          }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setParameters(title: String, value: String){
        nameSizeLabel.text = title
        valueSizeLabel.text = value
    }
    
}
