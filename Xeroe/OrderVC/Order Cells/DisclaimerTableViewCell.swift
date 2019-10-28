//
//  DisclaimerTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/21/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let checkedImageButton = "checked"
fileprivate let uncheckedImageButton = "unchecked"
fileprivate let urlXeroeTerm = "http://xeroe.co.uk/terms-conditions-of-use/"

protocol DisclaimerTableViewCellDelegate {
    func isChecked(isChecked: Bool)
    func getPriceTap()
}

class DisclaimerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.setLabelStyle(textLabel: disclaimer, fontLabel: UIFont(name: robotoMedium, size: 18), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var checkButton: CheckButton! {
        didSet {
            checkButton.setParametersImage(checkedImage: UIImage(named: checkedImageButton), uncheckedImage: UIImage(named: uncheckedImageButton))
            checkButton.addTarget(self, action: #selector(checkCollectionAddressButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var clickToAcceptLabel: UILabel! {
        didSet {
            clickToAcceptLabel.setLabelStyle(textLabel: clickToAccept, fontLabel: UIFont(name: robotoRegular, size: 17), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var termsAndConditionsButton: ButtonWithCornerRadius!  {
        didSet {
            termsAndConditionsButton.setParameters(text: termsAndConditions, font: UIFont(name: robotoBold, size: 17), tintColor: .darkText, backgroundColor: .white)
            termsAndConditionsButton.addTarget(self, action: #selector(termsAndConditionsButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var acceptedTermsLabel: UILabel! {
        didSet {
            acceptedTermsLabel.setLabelStyle(textLabel: ensureAccepted, fontLabel: UIFont(name: robotoRegular, size: sizeFontError), colorLabel: errorColor)
        }
    }
    
    @IBOutlet weak var getPriceButton: ButtonWithCornerRadius!  {
           didSet {
               getPriceButton.setParameters(text: getPrice, font: UIFont(name: robotoRegular, size: 17), tintColor: .white, backgroundColor: darkBlue)
               getPriceButton.addTarget(self, action: #selector(getPriceTap), for: .touchUpInside)
           }
       }
    
    
    var delegate: DisclaimerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        acceptedTermsLabel.isHidden = true
        checkButton.isChecked = false
    }
    
    @objc func checkCollectionAddressButtonTap() {
        acceptedTermsLabel.isHidden = true
        delegate?.isChecked(isChecked: checkButton.isChecked)
    }
    
    @objc func termsAndConditionsButtonTap() {
        if let url = URL(string: urlXeroeTerm), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("ooops, I can`t open url: \(urlXeroeTerm)")
        }
    }
    
    @objc func getPriceTap() {
        delegate?.getPriceTap()

    }
    
    func setParameters(isChecked: Bool) {
        acceptedTermsLabel.isHidden = true
        checkButton.isChecked = isChecked
    }
    
    func errorAccept(showError: Bool) {
        if showError {
            acceptedTermsLabel.isHidden = false

        }
    }
    
}
