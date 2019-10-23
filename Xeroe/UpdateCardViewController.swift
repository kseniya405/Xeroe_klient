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

protocol UpdateCardDelegate {
    func reloadCard()
}

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
    @IBOutlet weak var paymentSystemLabel: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberCard: UILabel!
    @IBOutlet weak var validDateLabel: UILabel!
    
    @IBOutlet weak var cvcLabel: UILabel!
    
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
    
    var delegate: UpdateCardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    @objc func addCardButtonTap() {
        if let cardSplit = cardNumberTextField.text?.split(separator: " ") {
            UserProfile.shared.endCardNumber = String(cardSplit[cardSplit.count - 1])
        }
        UserProfile.shared.valideDate = validDateTextField.text
        delegate?.reloadCard()
        self.dismiss()
    }
    

    
    @objc func textFieldEditingCange(textField: UITextField) {
        
        if textField.isEqual(cardholdersNameTextField) {
            editCardholderName(textField)
            return
        }
        
        if textField.isEqual(cardNumberTextField) {
            editCardNumber(textField)
            return
        }
        
        if textField.isEqual(validDateTextField) {
            editValidCardDate(textField)
            return
        }
        
        if textField.isEqual(CVCTextField) {
            editCardCVC(textField)
            return
        }
        
        
    }
    
    @objc func flipBack() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews, .curveEaseOut]
        
        UIView.transition(with: backCardView, duration: 0.5, options: transitionOptions, animations: {
            self.backCardView.isHidden = false

        })
        
        
        UIView.transition(with: frontCardView, duration: 0.5, options: transitionOptions, animations: {
        }) { (isOk) in
            self.frontCardView.isHidden = true
        }
        
        
    }
    
    @objc func flipFront() {
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews, .curveEaseOut]
        
        UIView.transition(with: frontCardView, duration: 0.5, options: transitionOptions, animations: {
            self.frontCardView.isHidden = false

        })
        
        
        UIView.transition(with: backCardView, duration: 0.5, options: transitionOptions, animations: {
        }) { (isOk) in
            self.backCardView.isHidden = true
        }
        
        

    }
    
    fileprivate func editCardNumber(_ textField: UITextField) {
        textField.text = textField.text?.filter{ $0.isNumber }
        
        checkPaymentSystem(number: textField.text ?? "")

        if var number = textField.text, !number.isEmpty {

            numberCard.textAlignment = .left
            if number.count > 4 {
                number.insert(" ", at: number.index(number.startIndex, offsetBy: 4))
            }
            if number.count > 9 {
                number.insert(" ", at: number.index(number.startIndex, offsetBy: 9))
            }
            if number.count > 14 {
                number.insert(" ", at: number.index(number.startIndex, offsetBy: 14))
            }
            if number.count > 19 {
                number.remove(at: number.index(number.startIndex, offsetBy: 19 ))
            }
            textField.text = number
            numberCard.text = number
            numberCard.alpha = 1
            
        } else {
            numberCard.textAlignment = .center
            numberCard.text = dotPattern
            numberCard.alpha = 0.7
        }
    }
    
    func checkPaymentSystem(number: String) {
            
        if let type = CreditCardTypeChecker.type(for: number) {
            paymentSystemLabel.image = type.image
        } else {
            paymentSystemLabel.image = nil
        }
            
    }
    
    fileprivate func editCardholderName(_ textField: UITextField) {
        if let name = textField.text, !name.isEmpty {
            nameLabel.text = name
            nameLabel.alpha = 1
        } else {
            nameLabel.text = fullName
            nameLabel.alpha = 0.7
        }
    }
    
    fileprivate func editValidCardDate(_ textField: UITextField) {
        textField.text = textField.text?.filter{ $0.isNumber }
        if var date = textField.text, !date.isEmpty {
            if date.count == 1, !(date.hasSuffix("0") || date.hasSuffix("1")) {
                date.insert("0", at: date.startIndex)
            }
            if date.count > 3 {
                date.insert("/", at: date.index(date.startIndex, offsetBy: 2))
            }
            if date.count > 5 {
                date.remove(at: date.index(date.startIndex, offsetBy: 5 ))
            }
            textField.text = date
            validDateLabel.text = date
            validDateLabel.alpha = 1
        } else {
            validDateLabel.text = mmyy
            validDateLabel.alpha = 0.7
        }
    }
    
    fileprivate func editCardCVC(_ textField: UITextField) {
        textField.text = textField.text?.filter{ $0.isNumber }
        if var cvc = textField.text, !cvc.isEmpty {
            if cvc.count > 3 {
                cvc.remove(at: cvc.index(cvc.startIndex, offsetBy: 3 ))
            }
            textField.text = cvc
            cvcLabel.text = cvc
            cvcLabel.alpha = 1
        } else {
            cvcLabel.text = "•••"
            cvcLabel.alpha = 0.7
        }
    }
    
}
