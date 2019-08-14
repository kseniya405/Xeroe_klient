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
    
    
    let sections = ["GOODS", "PAYMENT METHOD", "clientData", "RECIPIENT", "Options", "Delivery type"]
    let typeOfNib = ["GoodsTableViewCell", "PaymentMethodTableViewCell", "ClientDataTableViewCell", "ClientAddresTableViewCell", "OptionsTableViewCell", "DeliveryTypeTableViewCell"]
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 0.0)
    
    var isDelivery: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for item in 0...sections.count-1 {
            tableView.register(UINib(nibName: typeOfNib[item], bundle: nil), forCellReuseIdentifier: sections[item])
        }
        tableView.register(UINib.init(nibName: "HeaderOrderTableView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "header")
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
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! HeaderOrderTableView
        
        let sectionNumberIsZero = section == 0
        headerView.goodsLabel.isHidden = !sectionNumberIsZero
        headerView.namesLabel.isHidden = sectionNumberIsZero
        headerView.noteLabel.isHidden = !sectionNumberIsZero

        headerView.namesLabel.text = sections[section]
        
        headerView.viewBackgdround.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.13).cgColor
        headerView.viewBackgdround.layer.shadowOpacity = 1
        headerView.viewBackgdround.layer.shadowRadius = 2
        headerView.viewBackgdround.layer.shadowOffset = CGSize(width: 0, height: 2)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 69
        }
        return 52
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
            case 2, 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "clientData", for: indexPath) as! ClientDataTableViewCell
                var isSender = indexPath.section == 2
                if !isDelivery {
                    isSender = !isSender
                }
                
                //!!!register in class ClientDataTableViewCell!!!!!
                cell.IDLabel.text = isSender ? "ID: # RD 27B86" : "ID: # CM 14C12"
                cell.nameLabel.text = isSender ? "Sandra Lee" : "Andy McMillian"
                cell.phoneLabel.text = isSender ? "+44 888 88 88" : "+44 555 55 55"
                cell.addressLabel.text = isSender ? "27 Old Gloucester Street, London WC1N" : "11 - 59 Hight Rd, East Finchley, London N2 8AW"
                let nameImage = isSender ? "userPhoto" : "clientPhoto"
                cell.photoImage.image = UIImage(named: nameImage)
                
                return cell

            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! OptionsTableViewCell
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section], for: indexPath) as! DeliveryTypeTableViewCell
                return cell
            default:
                return tableView.dequeueReusableCell(withIdentifier: sections[0], for: indexPath)
        }
    }
    
    
    
}
