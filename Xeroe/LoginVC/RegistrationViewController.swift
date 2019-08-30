//
//  RegistrationViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
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
    
    }
    
    @objc func loginButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    
    
}
