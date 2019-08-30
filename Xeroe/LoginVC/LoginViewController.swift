//
//  ViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var enterEmailLabel: UILabel! {
        didSet{
            enterEmailLabel.text = emailOrPhone
        }
    }
    
    @IBOutlet weak var enterPasswordLabel: UILabel! {
        didSet {
            enterPasswordLabel.text = enterPassword
        }
    }
    
    @IBOutlet weak var wrongPaswordLabel: UILabel!{
        didSet {
            wrongPaswordLabel.text = wrongPassword
        }
    }
    
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.text = password
        }
    }
    
    // text field login and password
    @IBOutlet weak var loginTextField: TextFieldWithCorner!
    @IBOutlet weak var passwordTextField: TextFieldWithCorner!
    
    @IBOutlet weak var visibilityPasswordButton: ButtonWithCornerRadius! {
        didSet {
            visibilityPasswordButton.addTarget(self, action: #selector(visibilityPasswordButtonTap), for: .touchUpInside)
        }
    }
    
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
        if UserDefaults.standard.string(forKey: "token") != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ContainerViewController
            self.navigationController?.pushViewController(initialViewController, animated: false)
        }
        
        super.viewDidLoad()

        
        viewModel.setError = { [weak self] (textField, isEmpty) in
            print("textfield is empty: ", isEmpty)
            
            self?.errorTextFieldPassword(passwordIsEmpty: textField == self?.passwordTextField && isEmpty, emailIsEmpty: isEmpty)
        }
        viewModel.goToHomeScreen = { [weak self] in
            self?.goToHomeScreen()
        }
    }
    
    
    fileprivate func errorTextFieldPassword(passwordIsEmpty: Bool, emailIsEmpty: Bool) {
        self.passwordTextField.errorInput(isError: true)
        self.loginTextField.errorInput(isError: emailIsEmpty)
        self.wrongPaswordLabel.isHidden = passwordIsEmpty
        self.enterPasswordLabel.isHidden = !passwordIsEmpty
        self.enterEmailLabel.isHidden = !emailIsEmpty
    }
    
    
    @objc func signInButtonTap(){
        self.showActivityIndicatory(uiView: self.view)
        viewModel.validateTextFields(textField: loginTextField)
        viewModel.validateTextFields(textField: passwordTextField)
        
        
        guard let login = loginTextField.text, let password = passwordTextField.text, !login.isEmpty, !password.isEmpty else{
            self.errorTextFieldPassword(passwordIsEmpty: passwordTextField.text?.isEmpty ?? true, emailIsEmpty: loginTextField.text == "")
            return
        }
        viewModel.login(login: login, password: password)
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
    
    @objc func visibilityPasswordButtonTap(){
        passwordTextField.isSecureTextEntry.toggle()
        let imageButtonName = passwordTextField.isSecureTextEntry ? "invisible" : "visible"
        visibilityPasswordButton.setImage(UIImage(named: imageButtonName), for: .normal)
        print(view.frame.size)
    }
    
    
}

extension UIViewController {
    public func chooseConstraint(_ sizeFrame: CGFloat, _ constraint: NSLayoutConstraint, _ heightOrWidth: String) {
        let heightDefault:CGFloat = 720
        let widthDefault:CGFloat = 320
        if heightOrWidth == "height" {
            constraint.constant = sizeFrame * (constraint.constant / heightDefault)
        } else {
            constraint.constant = sizeFrame * (constraint.constant / widthDefault)
        }
    }
    
    public func reloadConstraints(_ localArr: [NSLayoutConstraint], _ heightOrWidth: String) {
        
        var size = self.view.frame.width
        var i = 0
        if heightOrWidth == "height" {
            let heightFrame = self.view.frame.height
            let guide = view.safeAreaLayoutGuide
            size = heightFrame - guide.layoutFrame.size.height * 4
        }
        while i < localArr.count {
            chooseConstraint(size, localArr[i], "height")
            i+=1
        }
        
    }
    
    func showActivityIndicatory(uiView: UIView) {
        let activityIndicatory: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatory.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: 80);
        activityIndicatory.center = uiView.center
        activityIndicatory.hidesWhenStopped = true
        activityIndicatory.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicatory.color = UIColor(red: 0.12, green: 0.24, blue: 0.44, alpha: 1)
        uiView.addSubview(activityIndicatory)
        activityIndicatory.startAnimating()
    }
}

