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
    
    @IBOutlet weak var fbButton: UIButton!{
        didSet {
            fbButton.layer.cornerRadius = 2
            fbButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var gButton: UIButton!{
        didSet {
            gButton.layer.cornerRadius = 2
            gButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var usernameTextField: UITextField!
        {
        didSet {
            usernameTextField.layer.cornerRadius = 2
            usernameTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
        {
        didSet {
            emailTextField.layer.cornerRadius = 2
            emailTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var phoneTextField: UITextField!{
        didSet {
            phoneTextField.layer.cornerRadius = 2
            phoneTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet {
            passwordTextField.layer.cornerRadius = 2
            passwordTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet {
            confirmPasswordTextField.layer.cornerRadius = 2
            confirmPasswordTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var signUpButton: UIButton!{
        didSet {
            signUpButton.layer.cornerRadius = 2
            signUpButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 2
            loginButton.layer.masksToBounds = true
            loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    
    @objc func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allConstraints = [xeroLogoTopspace, connectWithTopSpace, facebookButtonTopSpace, lineTopSpace, usernameTopSpace, usernameTextFieldTopSpace, emailTextFieldTopSpace, phoneTopSpace, phoneTextFieldTopSpace, passwordTopSpace, passwordTextFieldTopSpace, password2TopSpace, password2TextFieldTopSpace, SignUpButtom, loginButtomTopSpace, textFieldSpace]
        reloadConstraints(allConstraints as! [NSLayoutConstraint])

    }
    



}
