//
//  ViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    
    //mutable constraints
    @IBOutlet weak var logoXeroTopSpace: NSLayoutConstraint!
    @IBOutlet weak var connectWithLableTopSpace: NSLayoutConstraint!
    @IBOutlet weak var logoFGTopSpace: NSLayoutConstraint!
    @IBOutlet weak var lineTopLogin: NSLayoutConstraint!
    @IBOutlet weak var loginLableTopSpace: NSLayoutConstraint!
    @IBOutlet weak var loginTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var passwordLableTopSpace: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var forgotButtomTopSpace: NSLayoutConstraint!
    @IBOutlet weak var signInButtomButtomSpace: NSLayoutConstraint!
    @IBOutlet weak var donthaveAccountButtomTopSpace: NSLayoutConstraint!
    @IBOutlet weak var heightTextField: NSLayoutConstraint!
    
    @IBOutlet weak var enterEmailLabel: UILabel!
    @IBOutlet weak var enterPasswordLabel: UILabel!
    @IBOutlet weak var wrongPaswordLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
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
    
    var defaults = UserDefaults.standard
    
 
    override func viewDidLoad() {
        if defaults.string(forKey: "token") != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ContainerViewController
            self.navigationController?.pushViewController(initialViewController, animated: false)
        }
        
        super.viewDidLoad()

        let allConstraints = [logoXeroTopSpace, connectWithLableTopSpace, logoFGTopSpace, lineTopLogin, loginLableTopSpace, loginTextFieldTopSpace, passwordLableTopSpace, passwordTextFieldTopSpace, forgotButtomTopSpace, signInButtomButtomSpace, donthaveAccountButtomTopSpace, heightTextField]
        
        reloadConstraints(allConstraints as! [NSLayoutConstraint], "height")
    }
    
    
    fileprivate func errorTextFieldPassword(passwordIsEmpty: Bool, emailIsEmpty: Bool) {
        self.passwordTextField.layer.masksToBounds = true
        self.passwordTextField.layer.borderColor = UIColor(red: 1, green: 0, blue:00, alpha: 1.0).cgColor
        self.passwordTextField.layer.borderWidth = 2.0
        self.wrongPaswordLabel.textColor = passwordIsEmpty ? .clear : .red
        self.enterPasswordLabel.textColor = passwordIsEmpty ? .red : .clear
        self.enterPasswordLabel.backgroundColor = passwordIsEmpty ? .white : .clear
        self.enterEmailLabel.textColor = emailIsEmpty ? .red : .clear
        self.enterEmailLabel.backgroundColor = emailIsEmpty ? .white : .clear
        self.loginTextField.layer.masksToBounds = true
        self.loginTextField.layer.borderWidth = 2.0
        self.loginTextField.layer.borderColor = emailIsEmpty ? UIColor(red: 1, green: 0, blue:00, alpha: 1.0).cgColor : UIColor(red: 1, green: 0, blue:00, alpha: 0.0).cgColor
        
    }

    
    @objc func signInButtonTap(){
        
        guard let login = loginTextField.text, let password = passwordTextField.text, !login.isEmpty, !password.isEmpty else{
            self.errorTextFieldPassword(passwordIsEmpty: passwordTextField.text == "", emailIsEmpty: loginTextField.text == "")
            return
        }
        
        
        RestApi().login(login: login, password: password) { (isOk, token) in
            DispatchQueue.main.async {
                guard isOk, let token = token else {
                    self.errorTextFieldPassword(passwordIsEmpty: self.passwordTextField.text == "", emailIsEmpty: self.loginTextField.text == "")
                    
                    return
                }
                self.defaults.set(token, forKey: "token")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ContainerViewController
                self.navigationController?.pushViewController(initialViewController, animated: false)
            
            }
        }
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
    }
    
    
}

extension UIViewController {
    public func chooseConstraint(_ sizeFrame: CGFloat, _ constraint: NSLayoutConstraint, _ heightOrWidth: String) {
        let heightDefolt:CGFloat = 720
        let widthDefolt:CGFloat = 320
        if heightOrWidth == "height" {
            constraint.constant = sizeFrame * (constraint.constant / heightDefolt)
        } else {
            constraint.constant = sizeFrame * (constraint.constant / widthDefolt)
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
}

