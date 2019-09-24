//
//  ViewController+dismiss.swift
//  Xeroe
//
//  Created by Денис Марков on 9/24/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

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
