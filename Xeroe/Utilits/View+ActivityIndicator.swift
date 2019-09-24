//
//  UIView+ActivityIndicator.swift
//  Xeroe
//
//  Created by Денис Марков on 9/24/19.
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
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        }
        activityIndicator.color = activityIndicatorColor
        activityIndicator.hidesWhenStopped = true
        
        // add and start
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        return activityIndicator
    }
    
    func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) -> Void {
        activityIndicator.stopAnimating()
    }
}
