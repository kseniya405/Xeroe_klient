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
    
    /**
     sets label parameters and style
     */
    func setLabelStyle(_ textLabel: String, _ fontLabel: UIFont?, _ colorLabel: UIColor) {
        self.text = textLabel
        self.font = fontLabel
        self.textColor = colorLabel
    }
}

extension UIImageView {
    
    //uploads a picture from the link and assigns it to UIImageView
    func getImageFromUrl(urlAvatar: String){
        let url = linkApiStart + urlAvatar
        guard let imgURL: NSURL = NSURL(string: url), let imgData: NSData = NSData(contentsOf: imgURL as URL) else {
            self.image = UIImage(named: "defaultAvatar")
            return
        }
        self.image = UIImage(data: imgData as Data)
    }
}

extension UIViewController {
    func dismiss() {
        let vcs = self.navigationController?.viewControllers
        if ((vcs?.contains(self)) != nil) {
            self.navigationController?.popViewController(animated: false)
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
