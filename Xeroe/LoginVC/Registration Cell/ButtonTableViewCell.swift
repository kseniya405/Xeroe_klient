//
//  ButtonTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/4/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol ButtonDelegate {
    func registerButtonTap()
}

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var registerButton: ButtonWithCornerRadius! {
        didSet {
            registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
        }
    }
    
    var delegate: ButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @objc func registerButtonTap() {
        delegate?.registerButtonTap()
    }
    
    func setParameters(text: String, font: UIFont?, tintColor: UIColor, backgroundColor: UIColor) {
        registerButton.setParameters(text: text, font: font, tintColor: tintColor, backgroundColor: backgroundColor)
    }
    
    
    
}
