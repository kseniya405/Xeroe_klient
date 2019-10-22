//
//  UpdateCardViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 10/21/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let cornerRadiusCard: CGFloat = 8
fileprivate let cornerRadiusBackgroundStackView: CGFloat = 4

class UpdateCardViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var cardImageView: UIImageView! {
        didSet {
            cardImageView.layer.masksToBounds = true
            cardImageView.layer.cornerRadius = cornerRadiusCard
        }
    }
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            backImageView.layer.masksToBounds = true
            backImageView.layer.cornerRadius = cornerRadiusCard
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberCard: UILabel!
    @IBOutlet weak var validDateLabel: UILabel!
    @IBOutlet weak var backgroundStackView: UIView! {
        didSet {
            backgroundStackView.layer.masksToBounds = true
            backgroundStackView.layer.cornerRadius = cornerRadiusBackgroundStackView
        }
    }
    @IBOutlet weak var cardholdersNameTextField: UITextField! {
        didSet {
            cardholdersNameTextField.addTarget(self, action: #selector(textFieldEditingCange(textField:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var cardNumberTextField: UITextField! {
        didSet {
            cardNumberTextField.addTarget(self, action: #selector(textFieldEditingCange(textField:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var validDateTextField: UITextField!  {
        didSet {
            validDateTextField.addTarget(self, action: #selector(textFieldEditingCange(textField:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var CVCTextField: UITextField!  {
        didSet {
            CVCTextField.addTarget(self, action: #selector(textFieldEditingCange(textField:)), for: .editingChanged)
            CVCTextField.addTarget(self, action: #selector(flipBack), for: .editingDidBegin)
            CVCTextField.addTarget(self, action: #selector(flipFront), for: .editingDidEnd)
        }
    }
    @IBOutlet weak var addCardButton: ButtonWithCornerRadius!    {
        didSet {
            addCardButton.setParameters(text: "Add Card", font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: .white, backgroundColor: darkBlue)
            addCardButton.addTarget(self, action: #selector(addCardButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var backCardView: UIView!
    @IBOutlet weak var frontCardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    @objc func addCardButtonTap() {
        
    }
    
    //    @objc func textFieldEditingDidBegin(textField: UITextField) {
    //        perform(#selector(flip), with: nil, afterDelay: 2)
    //    }
    
    @objc func textFieldEditingCange(textField: UITextField) {
        
        if textField.isEqual(cardholdersNameTextField) {
            
            if let text = textField.text, !text.isEmpty {
                nameLabel.text = text
                nameLabel.alpha = 1
            } else {
                nameLabel.text = fullName
                nameLabel.alpha = 0.7
            }
            return
        }
        
        if textField.isEqual(cardNumberTextField) {
            textField.text = textField.text?.filter{ $0.isNumber }
            if var text = textField.text, !text.isEmpty {
                numberCard.textAlignment = .left
                if text.count > 4 {
                    text.insert(" ", at: text.index(text.startIndex, offsetBy: 4))
                }
                if text.count > 9 {
                    text.insert(" ", at: text.index(text.startIndex, offsetBy: 9))
                }
                if text.count > 13 {
                    text.insert(" ", at: text.index(text.startIndex, offsetBy: 14))
                }
                if text.count > 19 {
                    text.remove(at: text.index(text.startIndex, offsetBy: 19 ))
                }
                textField.text = text
                numberCard.text = text
                numberCard.alpha = 1
            } else {
                numberCard.textAlignment = .center
                numberCard.text = dotPattern
                numberCard.alpha = 0.7
            }
            return
        }
        
        if textField.isEqual(validDateTextField) {
            textField.text = textField.text?.filter{ $0.isNumber }
            if var text = textField.text, !text.isEmpty {
                if text.count == 1, !text.hasSuffix("0") || !text.hasSuffix("1") {
                    text.insert("0", at: text.startIndex)
                }
                if text.count > 3 {
                    text.insert("/", at: text.index(text.startIndex, offsetBy: 2))
                }
                if text.count > 5 {
                    text.remove(at: text.index(text.startIndex, offsetBy: 5 ))
                }
                textField.text = text
                validDateLabel.text = text
                validDateLabel.alpha = 1
            } else {
                validDateLabel.text = mmyy
                validDateLabel.alpha = 0.7
            }
            return
        }
        
        
    }
    
    @objc func flipBack() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews, .curveEaseOut]
        
        UIView.transition(with: backCardView, duration: 1, options: transitionOptions, animations: {
            //            self.frontCardView.bringSubviewToFront(self.backCardView)
            self.frontCardView.isHidden = true
        })
        
        
        UIView.transition(with: frontCardView, duration: 1, options: transitionOptions, animations: {
        }) { (isOk) in
             self.backCardView.isHidden = false
        }
        
    }
    
    @objc func flipFront() {
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews, .curveEaseOut]
        
        UIView.transition(with: frontCardView, duration: 1, options: transitionOptions, animations: {
            //            self.frontCardView.bringSubviewToFront(self.backCardView)
            self.frontCardView.isHidden = false
        })
        
        
        UIView.transition(with: backCardView, duration: 1, options: transitionOptions, animations: {
        }) { (isOk) in
            self.backCardView.isHidden = true
        }
        
        
        
        
    }
    
    
}
