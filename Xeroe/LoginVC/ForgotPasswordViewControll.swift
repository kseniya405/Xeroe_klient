//
//  ForgotPasswordViewControll.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierLoginVC = "LoginViewController"

class ForgotPasswordViewControll: UIViewController {
    
    @IBOutlet weak var viewInputEmail: UIStackView!
    @IBOutlet weak var viewCheckYourInbox: UIStackView!
    @IBOutlet weak var envelopeImage: UIImageView! {
           didSet {
            envelopeImage.image = #imageLiteral(resourceName: "envelope")
           }
       }
    @IBOutlet weak var checkYourInboxLabel: UILabel! {
        didSet {
            checkYourInboxLabel.setLabelStyle(textLabel: checkInbox, fontLabel: UIFont(name: robotoRegular, size: 14), colorLabel: .black)
        }
    }
    
    @IBOutlet weak var topBarLabel: UILabel! {
        didSet {
            topBarLabel.setLabelStyle(textLabel: requestPassword, fontLabel: UIFont(name: robotoMedium, size: sizeFontBarLabel), colorLabel: .white)
        }
    }
    
    @IBOutlet weak var backButton: UIButton!{
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var emailTextField: TextFieldWithCorner! {
        didSet {
            emailTextField.addTarget(self, action: #selector(changeColorBorderTextField(_:)), for: UIControl.Event.editingDidBegin)

            emailTextField.addTarget(self, action: #selector(changeColorBorderTextField(_:)), for: UIControl.Event.editingChanged)
            emailTextField.addTarget(self, action: #selector(unchangeColorBorderTextField(_:)), for: UIControl.Event.editingDidEnd)
        }
    }
    @IBOutlet weak var wrongEmailLabel: UILabel! {
        didSet {
            wrongEmailLabel.setLabelStyle(textLabel: enterEmail, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: errorColor)
        }
    }
    
    @IBOutlet weak var resetPasswordButton: ButtonWithCornerRadius! {
        didSet {
            resetPasswordButton.setParameters(text: resetPassword, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: .white, backgroundColor: darkBlue)
            resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTap), for: .touchUpInside)
        }
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    @objc func changeColorBorderTextField(_ textField: TextFieldWithCorner) {
        wrongEmailLabel.isHidden = true
        textField.changeColor(isChabge: true)
    }
    
    @objc func unchangeColorBorderTextField(_ textField: TextFieldWithCorner) {
        textField.changeColor(isChabge: false)
    }
    
    @objc func resetPasswordButtonTap() {
        if emailTextField.validateEmail(), !(emailTextField.text?.isEmpty ?? true) {
            viewInputEmail.isHidden = true
            viewCheckYourInbox.isHidden = false
        } else {
            guard let emailText = emailTextField.text, !emailText.isEmpty else {
                wrongEmailLabel.text = enterEmail
                wrongEmailLabel.isHidden = false
                return
            }
            wrongEmailLabel.text = wrongEmail
            wrongEmailLabel.isHidden = false
        }
    }
}
