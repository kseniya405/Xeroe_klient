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
            deliveryButton.addTarget(self, action: #selector (orderDetailOpenDelivery), for: .touchUpInside)
        }
    }
    @IBOutlet weak var pickUpButton: UIButton!{
        didSet {
            pickUpButton.addTarget(self, action: #selector (orderDetailOpenPickUp), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var backButton: UIButton!{
        didSet {
            backButton.addTarget(self, action: #selector (backButtonTap), for: .touchUpInside)
        }
    }
    
    var clientDataDictionary: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @objc func backButtonTap() {
        self.dismiss()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "FoundUserDetailViewController") as! FoundUserDetailViewController
//        initialViewController.clientDataDictionary = clientDataDictionary
//        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    
    @objc func orderDetailOpenDelivery() {
        orderDetailOpenAs(isDelivery: true)
    }
    
    @objc func orderDetailOpenPickUp() {
        orderDetailOpenAs(isDelivery: false)
    }
    
    func orderDetailOpenAs(isDelivery: Bool) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        
        // isDelivery - shows whether it is delivery or receipt
        userIsSender = isDelivery
        initialViewController.isDelivery = isDelivery
        initialViewController.clientDataDictionary = clientDataDictionary
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
}
