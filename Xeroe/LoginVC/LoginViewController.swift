//
//  ViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginFormView: loginFormView!
    @IBOutlet weak var fbButton: ButtonWithCornerRadius!
    @IBOutlet weak var signInButton: ButtonWithCornerRadius! {
        didSet {
            signInButton.addTarget(self, action: #selector(signInButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var forgotButton: ButtonWithCornerRadius!{
        didSet {
            forgotButton.addTarget(self, action: #selector(forgotButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var createAccountButton: ButtonWithCornerRadius! {
        didSet {
            createAccountButton.addTarget(self, action: #selector(createAccountButtonTap), for: .touchUpInside)
        }
    }
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        if UserDefaults.standard.string(forKey: DefaultsKeys.token.rawValue) != nil {
            goToHomeScreen()
        }
        
        super.viewDidLoad()
        
        viewModel.setError = { [weak self] (passwordIsEmpty, emailIsEmpty) in
            DispatchQueue.main.async {
                self?.loginFormView.errorTextField(passwordIsEmpty: passwordIsEmpty, emailIsEmpty: emailIsEmpty)
            }
            
        }
        viewModel.goToHomeScreen = { [weak self] in
            DispatchQueue.main.async {
                self?.goToHomeScreen()
            }
            
        }
    }
    
    
    @objc func signInButtonTap(){
        let activityIndicator = self.view.showActivityIndicator()
        if viewModel.validateTextFields(loginFormView: loginFormView) {
            viewModel.login(loginFormView: loginFormView)
        }
        activityIndicator.stopAnimating()
    }
    
    func goToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ContainerViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func forgotButtonTap(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewControll") as! ForgotPasswordViewControll
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func createAccountButtonTap(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
}
