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
    @IBOutlet weak var fbHeight: NSLayoutConstraint!
    @IBOutlet weak var heightTextField: NSLayoutConstraint!
    
    // text field login and password
    @IBOutlet weak var loginTextField: UITextField!{
        didSet{
            loginTextField.layer.cornerRadius = 2
            loginTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.layer.cornerRadius = 2
            passwordTextField.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var fbButton: UIButton! {
        didSet{
            fbButton.layer.cornerRadius = 2
            fbButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = 2
            signInButton.layer.masksToBounds = true
            signInButton.addTarget(self, action: #selector(setLogin), for: .touchUpInside)
        }
    }
    
    @objc func setLogin(){
        let parameters: [String: String] = ["username": loginTextField.text!, "password": passwordTextField.text!]
        
        Alamofire.request("http://xeroe.kinect.pro:8091/api/auth/login", method: .post, parameters: parameters).responseJSON { response in
            
        print(response)
            let mapVC = MapViewController()
            self.navigationController?.pushViewController(mapVC, animated: false)
        }
    }
    
    @IBOutlet weak var forgotButton: UIButton!{
        didSet {
            forgotButton.layer.cornerRadius = 2
            forgotButton.layer.masksToBounds = true
            forgotButton.addTarget(self, action: #selector(openForgotPasswordViewControll), for: .touchUpInside)
        }
    }
    
    @objc func openForgotPasswordViewControll(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewControll") as! ForgotPasswordViewControll
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @IBOutlet weak var createAccountButton: UIButton! {
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
    
        let parameters = ["username": "example@gmail.com", "password": "password", "access_token": userData.userData.access_token]
        
        Alamofire.request("http://xeroe.kinect.pro:8091/api/auth/login", method: .post, parameters: parameters).responseJSON { response in
            
            print(response)
        }

        let allConstraints = [logoXeroTopSpace, connectWithLableTopSpace, logoFGTopSpace, lineTopLogin, loginLableTopSpace, loginTextFieldTopSpace, passwordLableTopSpace, passwordTextFieldTopSpace, forgotButtomTopSpace, signInButtomButtomSpace, donthaveAccountButtomTopSpace, fbHeight, heightTextField]
        
        reloadConstraints(allConstraints as! [NSLayoutConstraint])
    }

}

extension UIViewController {
    public func chooseConstraint(_ heightFrame: CGFloat, _ constraint: NSLayoutConstraint) {
        let heithDefolt:CGFloat = 720
        constraint.constant = heightFrame * (constraint.constant / (heithDefolt-20))
    }
    
    public func reloadConstraints(_ localArr: [NSLayoutConstraint]) {
        let heightFrame = self.view.frame.height
        let guide = view.safeAreaLayoutGuide
        let height = heightFrame - guide.layoutFrame.size.height
        var i = 0
        while i < localArr.count {
            chooseConstraint(height, localArr[i])
            i+=1
        }
        
    }
}




