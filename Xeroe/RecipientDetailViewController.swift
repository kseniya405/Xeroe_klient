//
//  CompanyDetailViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/6/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class RecipientDetailViewController: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!{
        didSet {
            buttonBack.addTarget(self, action: #selector(buttonNoTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var idRecipient: UILabel!
    @IBOutlet weak var nameRecipient: UILabel!
    @IBOutlet weak var addressRecipient: UITextView!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var buttonNo: ButtonWithCornerRadius! {
        didSet {
            buttonNo.layer.borderColor = UIColor(red: 0.12, green: 0.24, blue: 0.44, alpha: 1).cgColor
            buttonNo.addTarget(self, action: #selector(buttonNoTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var buttonYes: ButtonWithCornerRadius!{
        didSet {
            buttonYes.layer.borderColor = UIColor(red: 0.12, green: 0.24, blue: 0.44, alpha: 1).cgColor
            buttonYes.addTarget(self, action: #selector(buttonYesTap), for: .touchUpInside)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonNoTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ContainerViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func buttonYesTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "FlowPickUpOrDeliveryViewController") as! FlowPickUpOrDeliveryViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }

}
