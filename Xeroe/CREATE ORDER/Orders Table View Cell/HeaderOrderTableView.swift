//
//  HeaderOrderTableView.swift
//  Xeroe
//
//  Created by Денис Марков on 8/14/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class HeaderOrderTableView: UITableViewHeaderFooterView {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var goodsLabel: UILabel!
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBackground.layer.shadowColor = shadowColor.cgColor
        self.viewBackground.layer.shadowOpacity = 1
        self.viewBackground.layer.shadowRadius = 2
        self.viewBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func setParameters(sectionNumberIsZero: Bool, sectionName: String){
        self.goodsLabel.isHidden = !sectionNumberIsZero
        self.namesLabel.isHidden = sectionNumberIsZero
        self.noteLabel.isHidden = !sectionNumberIsZero
        self.namesLabel.text = sectionName
    }
}
