//
//  PaymentsViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 10/21/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let updateCardViewController = "UpdateCardViewController"
fileprivate let endNumberCard = "1243"

class PaymentsViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var cardImageView: UIImageView!  {
        didSet {
            cardImageView.layer.masksToBounds = true
            cardImageView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var numberCard: UILabel!
    @IBOutlet weak var validDateLabel: UILabel!
    
    @IBOutlet weak var updateCardButton: ButtonWithCornerRadius!  {
        didSet {
            updateCardButton.setParameters(text: updateCard, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: .white, backgroundColor: darkBlue)
            updateCardButton.addTarget(self, action: #selector(updateCardButtonTap), for: .touchUpInside)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberCard.text = dotNumber + (UserProfile.shared.endCardNumber ?? endNumberCard)
        validDateLabel.text = UserProfile.shared.valideDate
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    @objc func updateCardButtonTap() {
        let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: updateCardViewController) as! UpdateCardViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
}
