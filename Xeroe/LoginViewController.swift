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
    
    @IBOutlet weak var enterPasswordLabel: UILabel!
    @IBOutlet weak var wrongPaswordLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
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
            
            guard let newsResponse = response.result.value as? [String:Any] else{
                print("Error: \(String(describing: response.result.error))")
                return
            }
            
            let localArray = newsResponse
            guard (localArray["message"] as? String) != nil else{
                let mapVC = MapViewController()
                self.navigationController?.pushViewController(mapVC, animated: false)
                return
            }
            
            self.wrongPaswordLabel.textColor = .red
            self.enterPasswordLabel.textColor = .red
            self.passwordLabel.textColor = .white
            self.enterPasswordLabel.backgroundColor = .white
            
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

        let allConstraints = [logoXeroTopSpace, connectWithLableTopSpace, logoFGTopSpace, lineTopLogin, loginLableTopSpace, loginTextFieldTopSpace, passwordLableTopSpace, passwordTextFieldTopSpace, forgotButtomTopSpace, signInButtomButtomSpace, donthaveAccountButtomTopSpace, fbHeight, heightTextField]
        
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




