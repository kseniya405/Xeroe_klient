//
//  RegistrationViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var xeroLogoTopspace: NSLayoutConstraint!
    @IBOutlet weak var connectWithTopSpace: NSLayoutConstraint!
    @IBOutlet weak var facebookButtonTopSpace: NSLayoutConstraint!
    @IBOutlet weak var lineTopSpace: NSLayoutConstraint!
    @IBOutlet weak var usernameTopSpace: NSLayoutConstraint!
    @IBOutlet weak var usernameTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var emailTopSpace: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var phoneTopSpace: NSLayoutConstraint!
    @IBOutlet weak var phoneTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var passwordTopSpace: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var password2TopSpace: NSLayoutConstraint!
    @IBOutlet weak var password2TextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var SignUpButtom: NSLayoutConstraint!
    @IBOutlet weak var loginButtomTopSpace: NSLayoutConstraint!
    
    @IBAction func Login(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allConstraints = [xeroLogoTopspace, connectWithTopSpace, facebookButtonTopSpace, lineTopSpace, usernameTopSpace, usernameTextFieldTopSpace, emailTextFieldTopSpace, phoneTopSpace, phoneTextFieldTopSpace, passwordTopSpace, passwordTextFieldTopSpace, password2TopSpace, password2TextFieldTopSpace, SignUpButtom, loginButtomTopSpace]
        reloadConstraints(allConstraints as! [NSLayoutConstraint])

    }
    



}
