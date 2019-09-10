//
//  LoginViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierForgotPasswordVC = "ForgotPasswordViewController"
fileprivate let identifierRegistrationVC = "RegistrationViewController"
fileprivate let identifierContainerVC = "ContainerViewController"


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginFormView: LoginFormView!
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
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        if UserProfile.shared.login != nil {
            viewModel.tokenValidation()
        }
        super.viewDidLoad()

        viewModel.setError = { [weak self] (passwordIsEmpty, emailIsEmpty) in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.loginFormView.errorTextField(passwordIsEmpty: passwordIsEmpty, emailIsEmpty: emailIsEmpty)
            }
            
        }
        
        viewModel.goToHomeScreen = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.goToHomeScreen()
            }
            
        }
    }
    
    @objc func signInButtonTap(){
        activityIndicator = self.view.showActivityIndicator()
        viewModel.login(loginFormView: loginFormView)
    }

    @objc func forgotButtonTap(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierForgotPasswordVC) as! ForgotPasswordViewControll
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func createAccountButtonTap(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierRegistrationVC) as! RegistrationViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    func goToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierContainerVC) as! ContainerViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
}
