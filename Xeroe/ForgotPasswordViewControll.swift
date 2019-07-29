//
//  ForgotPasswordViewControll.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit


class ForgotPasswordViewControll: UIViewController {
    
    @IBAction func backToAutorizathion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(initialViewController, animated: false, completion: nil)
    }
    

    @IBOutlet weak var xeroLogoTopSpace: NSLayoutConstraint!
    @IBOutlet weak var emailAdressTopSpace: NSLayoutConstraint!
    @IBOutlet weak var loginTextFieldTopSpace: NSLayoutConstraint!
    @IBOutlet weak var resetPasswordButtonTopSpace: NSLayoutConstraint!
    @IBOutlet weak var textViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var checkMailButtomTopSpace: NSLayoutConstraint!
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allConstraints = [xeroLogoTopSpace, loginTextFieldTopSpace, resetPasswordButtonTopSpace, textViewTopSpace, checkMailButtomTopSpace]

        reloadConstraints(allConstraints as! [NSLayoutConstraint])

        
    }



}
