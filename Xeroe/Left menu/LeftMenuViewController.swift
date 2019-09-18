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


class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!{
        didSet{
            photoImage.layer.cornerRadius = photoImage.frame.height / 2.0
            photoImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIDXeroeLabel: UILabel!
    @IBOutlet weak var leftMenu: UIView!
    @IBOutlet weak var leftMenuTableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!{
        didSet {
            logoutButton.addTarget(self, action: #selector(goToLoginView), for: .touchUpInside)
        }
    }
    
    let cellLeftMenuNames = [yourDeliveries, help, payments, freeDeliveries, setting, notifications]
    
    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuTableView.dataSource = self
        leftMenuTableView.delegate = self
        leftMenuTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        leftMenuTableView.tableFooterView = UIView()
        
        userNameLabel.text = UserProfile.shared.email
        userIDXeroeLabel.text = UserProfile.shared.xeroeId
        
        guard let urlAvatar: String = UserProfile.shared.avatar else {
            print("error avatar")
            return
        }
        photoImage.getImageFromUrl(urlAvatar: urlAvatar)
    }
    
    @objc func goToLoginView() {
        UserProfile.shared.clear(callback: { (isOk) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: loginViewControllerIdentifier) as! LoginViewController
            self.navigationController?.pushViewController(initialViewController, animated: false)
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
    
}
