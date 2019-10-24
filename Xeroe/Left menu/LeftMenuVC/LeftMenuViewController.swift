//
//  LeftMenuViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/31/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "LeftMenuTableViewCell"
fileprivate let loginViewControllerIdentifier = "LoginViewController"
fileprivate let paymentsViewControllerIdentifier = "PaymentsViewController"
fileprivate let vatNumber = "320491336"
fileprivate let urlXeroeFaq = "http:/xeroe.co.uk/faqs/"

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var leftMenu: UIView!
    @IBOutlet weak var leftMenuTableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!{
        didSet {
            logoutButton.addTarget(self, action: #selector(goToLoginView), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var xeroeVATNumberLabel: UILabel! {
        didSet {
            xeroeVATNumberLabel.setLabelStyle(textLabel: (xeroeVATNumber + vatNumber), fontLabel: UIFont(name: robotoRegular, size: 13), colorLabel: grayTextColor)
        }
    }
    
    
    let cellLeftMenuNames = [yourDeliveries, payments, help]
    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuTableView.dataSource = self
        leftMenuTableView.delegate = self
        leftMenuTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        leftMenuTableView.tableFooterView = UIView()
        
        userNameLabel.text = UserProfile.shared.email

    }
    
    @objc func goToLoginView() {
        UserProfile.shared.clear(callback: { (isOk) in
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: loginViewControllerIdentifier) as! LoginViewController
                self.navigationController?.pushViewController(initialViewController, animated: false)
            }
        })
    }
    
}

extension LeftMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLeftMenuNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeftMenuTableViewCell
        if indexPath.row < cellLeftMenuNames.count {
            cell.setData(nameCell: cellLeftMenuNames[indexPath.row], isSelected: cell.isSelected)
        }
        return cell
    }
}

extension LeftMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "YourDeliveriesViewController") as! YourDeliveriesViewController
            self.navigationController?.pushViewController(initialViewController, animated: false)
        case 1:
            let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: paymentsViewControllerIdentifier) as! PaymentsViewController
            self.navigationController?.pushViewController(initialViewController, animated: false)
        case 2:
            if let url = URL(string: urlXeroeFaq), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("ooops, I can`t open url: \(urlXeroeFaq)")
            }
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeftMenuTableViewCell
        cell.setData(nameCell: cellLeftMenuNames[indexPath.row], isSelected: true)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeftMenuTableViewCell
        cell.setData(nameCell: cellLeftMenuNames[indexPath.row], isSelected: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
}
