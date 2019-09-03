//
//  Extencions.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // launch Activity Indicator
    func showActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
        //location
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: 80);
        activityIndicator.center = self.center
        
        // style
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = activityIndicatorColor
        activityIndicator.hidesWhenStopped = true
        
        // add and start
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        return activityIndicator
    }
}

extension UILabel {
    
    //sets label parameters and style
    func labelStyle(_ textLabel: String, _ fontLabel: UIFont?, _ colorLabel: UIColor) {
        self.text = textLabel
        self.font = fontLabel
        self.textColor = colorLabel
    }
}
