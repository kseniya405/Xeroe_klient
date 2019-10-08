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
fileprivate let vatNumber = "320491336"


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
            xeroeVATNumberLabel.setLabelStyle(textLabel: (xeroeVATNumber + vatNumber), fontLabel: UIFont(name: robotoRegular, size: 13), colorLabel: greyTextColor)
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
            cell.setData(nameCell: cellLeftMenuNames[indexPath.row], isSelected: selectedIndexPath == indexPath)
        }
        return cell
    }
}

extension LeftMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previosSelectCell = selectedIndexPath {
            selectedIndexPath = indexPath
            tableView.reloadRows(at: [previosSelectCell], with: .none)
        }
        selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
}
