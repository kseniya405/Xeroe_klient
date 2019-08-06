//
//  LeftMenuViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/31/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var leftMenu: UIView!
    
    @IBOutlet weak var leftMenuTableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIButton!{
        didSet {
            logoutButton.addTarget(self, action: #selector(goToLoginView), for: .touchUpInside)
        }
    }
    
    @objc func goToLoginView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    
    fileprivate let cellIdentifier = "LeftMenuTableViewCell"
   
    let cellLeftMenuNames = ["Your deliveries", "Help", "Payments", "Free deliveries", "Settings", "Notifications"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuTableView.dataSource = self
        leftMenuTableView.delegate = self
        leftMenuTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        leftMenuTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLeftMenuNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeftMenuTableViewCell
        let nameCell = cellLeftMenuNames[indexPath.row]
        
        cell.nameCell.text = nameCell
        cell.iconImage.image = UIImage(named: nameCell)
        cell.iconImage.layer.cornerRadius = 2
        cell.iconImage.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: LeftMenuTableViewCell = tableView.cellForRow(at: indexPath)! as! LeftMenuTableViewCell
        selectedCell.contentView.backgroundColor = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1)
        selectedCell.nameCell.textColor = .white
        let image = UIImage(named: cellLeftMenuNames[indexPath.row])!.withRenderingMode(.alwaysTemplate)
        selectedCell.iconImage.image = image
        selectedCell.iconImage.tintColor = UIColor.white
        

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell: LeftMenuTableViewCell = tableView.cellForRow(at: indexPath)! as! LeftMenuTableViewCell
        deselectedCell.nameCell.textColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 0.87)
        deselectedCell.iconImage.image = UIImage(named: cellLeftMenuNames[indexPath.row])

    }

}
