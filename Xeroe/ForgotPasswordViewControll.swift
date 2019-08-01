//
//  ForgotPasswordViewControll.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit


class ForgotPasswordViewControll: UIViewController {
    
    @IBOutlet weak var checkEmailButton: UIButton!{
        didSet {
            checkEmailButton.layer.cornerRadius = 2
            checkEmailButton.layer.masksToBounds = true
            checkEmailButton.addTarget(self, action: #selector(backToAutorizathion), for: .touchUpInside)
        }
    }
    @objc func backToAutorizathion() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    

    @IBOutlet weak var xeroLogoTopSpace: NSLayoutConstraint!
    @IBOutlet weak var emailAdressTopSpace: NSLayoutConstraint!
    @IBOutlet weak var loginTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var resetPasswordButtonTopSpace: NSLayoutConstraint!
    @IBOutlet weak var textViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var checkMailButtomTopSpace: NSLayoutConstraint!
    @IBOutlet weak var checkEmailButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var resetPasswordButtomHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let registrationConstraints = [textViewTopSpace, checkMailButtomTopSpace, checkEmailButtonHeight, textFieldHeight, xeroLogoTopSpace, loginTextFieldTopSpace, resetPasswordButtonTopSpace, emailAdressTopSpace, resetPasswordButtomHeight]

        reloadConstraints(registrationConstraints as! [NSLayoutConstraint], "height")
    }



}
