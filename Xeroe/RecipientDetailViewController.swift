//
//  CompanyDetailViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/6/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class RecipientDetailViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!{
        didSet {
            backButton.addTarget(self, action: #selector(noButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var idRecipient: UILabel!
    @IBOutlet weak var nameRecipient: UILabel!
    @IBOutlet weak var addressRecipient: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var noButton: ButtonWithCornerRadius! {
        didSet {
            noButton.layer.borderColor = basicBlueColor.cgColor
            noButton.layer.borderWidth = 1
            noButton.addTarget(self, action: #selector(noButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var yesButton: ButtonWithCornerRadius!{
        didSet {
            yesButton.layer.borderColor = basicBlueColor.cgColor
            yesButton.addTarget(self, action: #selector(yesButtonTap), for: .touchUpInside)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func noButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func yesButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ShippingAgrinentViewController") as! ShippingAgrinentViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }

}
