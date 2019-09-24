//
//  UIImageView+loadUrlImage.swift
//  Xeroe
//
//  Created by Денис Марков on 9/24/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

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
