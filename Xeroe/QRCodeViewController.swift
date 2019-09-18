//
//  QRCodeViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/18/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var topBarLabel: UILabel! {
        didSet {
            topBarLabel.setLabelStyle(textLabel: driverArrived, fontLabel: UIFont(name: robotoMedium, size: 20), colorLabel: .white)
        }
    }
    
    @IBOutlet weak var showQRLabel: UILabel!
    
    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var orProvideCodeLabel: UILabel!
    @IBOutlet weak var uniqudeCodeTitle: UILabel!
    @IBOutlet weak var uniqudeCodeValue: UILabel! {
        didSet {
            uniqudeCodeValue.layer.masksToBounds = true
            uniqudeCodeValue.layer.cornerRadius = 4
            uniqudeCodeValue.layer.borderWidth = 2
            uniqudeCodeValue.layer.borderColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var nextButton: ButtonWithCornerRadius!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }

}
