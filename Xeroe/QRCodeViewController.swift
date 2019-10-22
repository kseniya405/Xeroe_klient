//
//  QRCodeViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/18/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit


protocol QRCodeViewControllerDelegate {
    func changView()
}

class QRCodeViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var topBarLabel: UILabel! {
        didSet {
            topBarLabel.setLabelStyle(textLabel: driverArrived, fontLabel: UIFont(name: robotoMedium, size: sizeFontBarLabel), colorLabel: .white)
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
            uniqudeCodeValue.layer.borderColor = cianColor.cgColor
        }
    }
    
    @IBOutlet weak var nextButton: ButtonWithCornerRadius! {
        didSet {
            nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
        }
    }
    
    var delegate: QRCodeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    @objc func nextButtonTap() {
        delegate?.changView()
        self.dismiss()
    }

}
