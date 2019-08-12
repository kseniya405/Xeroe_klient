//
//  OrderViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/9/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let sections = ["GOODS", "PAYMENT METHOD", "SENDER", "RECIPIENT", "Options", "Delivery type"]
    let typeOfNib = ["GoodsTableViewCell", "PaymentMethodTableViewCell", "SenderTableViewCell", "ResipientTableViewCell", "OptionsTableViewCell", "DeliveryTypeTableViewCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for item in 0...sections.count-1 {
            tableView.register(UINib(nibName: typeOfNib[item], bundle: nil), forCellReuseIdentifier: sections[item])
        }
    
        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ShippingAgrinentViewController") as! ShippingAgrinentViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }

}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = sections[section]
        label.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 0.99, alpha: 1)
        let shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)
        return label
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//
//        }
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GOODS", for: indexPath) as! GoodsTableViewCell
        cell.sizeToFit()
        return cell
    }
    


}
