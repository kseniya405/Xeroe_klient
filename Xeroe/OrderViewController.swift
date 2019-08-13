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
    let typeOfNib = ["GoodsTableViewCell", "PaymentMethodTableViewCell", "SenderTableViewCell", "RecipientTableViewCell", "OptionsTableViewCell", "DeliveryTypeTableViewCell"]
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 0.0)
    
    
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
        label.textColor = UIColor(red: 0.12, green: 0.24, blue: 0.44, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 67
        }
        return 50
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! GoodsTableViewCell
            
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! PaymentMethodTableViewCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! SenderTableViewCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! RecipientTableViewCell
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! OptionsTableViewCell
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! DeliveryTypeTableViewCell
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    
    
}
