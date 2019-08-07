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
    @IBOutlet weak var textFieldSpace: NSLayoutConstraint!
    @IBOutlet weak var signUpHeight: NSLayoutConstraint!    
    @IBOutlet weak var loginTrailing: NSLayoutConstraint!
    @IBOutlet weak var haveAccountLaining: NSLayoutConstraint!
    
    @IBOutlet weak var fbButton: ButtonWithCornerRadius!
    @IBOutlet weak var gButton: ButtonWithCornerRadius!
    @IBOutlet weak var usernameTextField: TextFieldWithCorner!
    @IBOutlet weak var emailTextField: TextFieldWithCorner!
    @IBOutlet weak var phoneTextField: TextFieldWithCorner!
    @IBOutlet weak var passwordTextField: TextFieldWithCorner!
    @IBOutlet weak var confirmPasswordTextField: TextFieldWithCorner!
    @IBOutlet weak var signUpButton: ButtonWithCornerRadius!
    @IBOutlet weak var loginButton: ButtonWithCornerRadius! {
        didSet {
            loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let heightConstraints = [xeroLogoTopspace, connectWithTopSpace, facebookButtonTopSpace, lineTopSpace, usernameTopSpace, usernameTextFieldTopSpace, emailTopSpace, emailTextFieldTopSpace, phoneTopSpace, phoneTextFieldTopSpace, passwordTopSpace, passwordTextFieldTopSpace, password2TopSpace, password2TextFieldTopSpace, SignUpButtom, loginButtomTopSpace, textFieldSpace, signUpHeight]
        reloadConstraints(heightConstraints as! [NSLayoutConstraint], "height")
        
        let widthConstraints = [loginTrailing, haveAccountLaining]
        reloadConstraints(widthConstraints as! [NSLayoutConstraint], "width")
        
    }
    
    @objc func loginButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    
    
}
