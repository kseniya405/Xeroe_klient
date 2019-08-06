//
//  ViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import Alamofire


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
    
    @IBOutlet weak var enterPasswordLabel: UILabel!
    @IBOutlet weak var wrongPaswordLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    // text field login and password
    @IBOutlet weak var loginTextField: TextFieldWithCorner!
    @IBOutlet weak var passwordTextField: TextFieldWithCorner!
    @IBOutlet weak var fbButton: ButtonWithCornerRadius!
    @IBOutlet weak var signInButton: ButtonWithCornerRadius! {
        didSet {
            signInButton.addTarget(self, action: #selector(setLogin), for: .touchUpInside)
        }
    }
    
    fileprivate func errorTextFieldPassword(passwordIsEmpty: Bool) {
        var colorWrongPassword: UIColor
        var colorEnterPassword: UIColor
        var colorBackgroundEnterPassword: UIColor
        if passwordIsEmpty {
            colorWrongPassword = .clear
            colorEnterPassword = .red
            colorBackgroundEnterPassword = .white
        } else {
            colorWrongPassword = .red
            colorEnterPassword = .clear
            colorBackgroundEnterPassword = .clear
        }
        self.passwordTextField.layer.masksToBounds = true
        self.passwordTextField.layer.borderColor = UIColor( red: 1, green: 0, blue:00, alpha: 1.0 ).cgColor
        self.passwordTextField.layer.borderWidth = 2.0
        self.wrongPaswordLabel.textColor = colorWrongPassword
        self.enterPasswordLabel.textColor = colorEnterPassword
        self.enterPasswordLabel.backgroundColor = colorBackgroundEnterPassword
    }
    
    @objc func setLogin(){
        
        guard let login = loginTextField.text, let password = passwordTextField.text, !login.isEmpty, !password.isEmpty else{
                self.errorTextFieldPassword(passwordIsEmpty: passwordTextField.text == "")
                return
        }
        RestApi().login(login: login, password: password) { (isOk, token) in
            
            guard isOk, let token = token else {
                self.errorTextFieldPassword(passwordIsEmpty: self.passwordTextField.text == "")
            return
        }
            userData.userData.access_token = token
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ContainerViewController
            self.navigationController?.pushViewController(initialViewController, animated: false)
        }
        
    }
    
    @IBOutlet weak var forgotButton: ButtonWithCornerRadius!{
        didSet {
            forgotButton.addTarget(self, action: #selector(openForgotPasswordViewControll), for: .touchUpInside)
        }
    }
    
    @objc func openForgotPasswordViewControll(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewControll") as! ForgotPasswordViewControll
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @IBOutlet weak var createAccountButton: ButtonWithCornerRadius! {
        didSet {
            createAccountButton.addTarget(self, action: #selector(openRegistrationViewController), for: .touchUpInside)
        }
    }
    
    @objc func openRegistrationViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let allConstraints = [logoXeroTopSpace, connectWithLableTopSpace, logoFGTopSpace, lineTopLogin, loginLableTopSpace, loginTextFieldTopSpace, passwordLableTopSpace, passwordTextFieldTopSpace, forgotButtomTopSpace, signInButtomButtomSpace, donthaveAccountButtomTopSpace, heightTextField]
        
        reloadConstraints(allConstraints as! [NSLayoutConstraint], "height")
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



