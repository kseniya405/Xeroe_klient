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
fileprivate let sizeFontButton: CGFloat = 12

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginFormView: LoginFormView!
    @IBOutlet weak var signInButton: ButtonWithCornerRadius! {
        didSet {
            signInButton.setParameters(text: signIn, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: .white, backgroundColor: darkBlue)
            signInButton.addTarget(self, action: #selector(signInButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var forgotButton: ButtonWithCornerRadius!{
        didSet {
            forgotButton.setParameters(text: forgotPassword, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: darkBlue, backgroundColor: .white)
            forgotButton.addTarget(self, action: #selector(forgotButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var createAccountButton: ButtonWithCornerRadius! {
        didSet {
            createAccountButton.setParameters(text: register, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: darkBlue, backgroundColor: .white)
            createAccountButton.addTarget(self, action: #selector(createAccountButtonTap), for: .touchUpInside)
        }
    }
    
    let viewModel = LoginViewModel()
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funcViewModel()
    }
    
    @objc func signInButtonTap() {
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
    
    fileprivate func funcViewModel() {
        viewModel.setError = { [weak self] (passwordIsEmpty, emailIsEmpty, emailIsWrong) in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.loginFormView.errorTextField(passwordIsEmpty: passwordIsEmpty, emailIsEmpty: emailIsEmpty, emailIsWrong: emailIsWrong)
            }
            
        }
        
        viewModel.goToHomeScreen = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.goToHomeScreen()
            }
            
        }
    }
    
    func goToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierContainerVC) as! ContainerViewController
        initialViewController.identifier = "HomeViewController"
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
}
