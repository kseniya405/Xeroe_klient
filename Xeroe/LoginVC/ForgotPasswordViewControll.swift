//
//  ForgotPasswordViewControll.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierLoginVC = "LoginViewController"

class ForgotPasswordViewControll: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!{
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var emailTextField: TextFieldWithCorner!
    @IBOutlet weak var resetPasswordButton: ButtonWithCornerRadius!
    
    @IBOutlet weak var messageForUsersTextView: UITextView!
    
    @IBOutlet weak var checkEmailButton: ButtonWithCornerRadius!{
        didSet {
            checkEmailButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func backButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierLoginVC) as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    
}
