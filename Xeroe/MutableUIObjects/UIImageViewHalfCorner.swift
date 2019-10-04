//
//  UIImageViewHalfCorner.swift
//  Xeroe
//
//  Created by Денис Марков on 10/4/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class UIImageViewHalfCorner: UIImageView {
    
    override func awakeFromNib() {
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self.frame.width, height: self.frame.height))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
  
}
