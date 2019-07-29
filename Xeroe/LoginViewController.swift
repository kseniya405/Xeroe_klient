//
//  ViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    

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
    
    
//    @IBAction func forgotPasswordButtom(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewControll") as! ForgotPasswordViewControll
//        self.present(initialViewController, animated: false, completion: nil)
//    }

    @IBAction func registrationTapButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.present(initialViewController, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allConstraints = [logoXeroTopSpace, connectWithLableTopSpace, logoFGTopSpace, lineTopLogin, loginLableTopSpace, loginTextFieldTopSpace, passwordLableTopSpace, passwordTextFieldTopSpace, forgotButtomTopSpace, signInButtomButtomSpace, donthaveAccountButtomTopSpace]
        reloadConstraints(allConstraints as! [NSLayoutConstraint])
    }

}

extension UIViewController {
    public func chooseConstraint(_ heightFrame: CGFloat, _ constraint: NSLayoutConstraint) {
        let heithDefolt:CGFloat = 720
        constraint.constant = heightFrame * (constraint.constant / heithDefolt)
    }
    
    public func reloadConstraints(_ localArr: [NSLayoutConstraint]) {
        let heightFrame = self.view.frame.height
        var i = 0
        while i < localArr.count {
            chooseConstraint(heightFrame, localArr[i])
            i+=1
        }
        
    }
}




