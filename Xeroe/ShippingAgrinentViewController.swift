//
//  ShippingAgrinentViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/9/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ShippingAgrinentViewController: UIViewController {

    @IBOutlet weak var deliveryButton: UIButton!{
        didSet {
            deliveryButton.addTarget(self, action: #selector (orderDetailOpen), for: .touchUpInside)
        }
    }
    @IBOutlet weak var pickUpButton: UIButton!{
        didSet {
            pickUpButton.addTarget(self, action: #selector (orderDetailOpen), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var buttonBack: UIButton!{
        didSet {
            buttonBack.addTarget(self, action: #selector (buttonBackTap), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @objc func buttonBackTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RecipientDetailViewController") as! RecipientDetailViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    
    @objc func orderDetailOpen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
}
