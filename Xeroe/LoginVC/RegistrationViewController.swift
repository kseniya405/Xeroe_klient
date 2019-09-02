//
//  RegistrationViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifier = "RegistrationTableViewCell"

class RegistrationViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var fbButton: ButtonWithCornerRadius!
    @IBOutlet weak var gButton: ButtonWithCornerRadius!
    @IBOutlet weak var usernameTextField: TextFieldWithCorner!
    @IBOutlet weak var emailTextField: TextFieldWithCorner!
    @IBOutlet weak var phoneTextField: TextFieldWithCorner!
    @IBOutlet weak var passwordTextField: TextFieldWithCorner!
    @IBOutlet weak var confirmPasswordTextField: TextFieldWithCorner!
    @IBOutlet weak var signUpButton: ButtonWithCornerRadius!
    @IBOutlet weak var loginButton: ButtonWithCornerRadius! {
        didSet {
            loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        }
    }
    let thumbnailSizeAdd = CGSize(width: 75.0, height: 48.0)
    
    let listQuestions = [username, email, phoneNumber, password, confirmPassword]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
//        tableView.rowHeight = tableView.frame.size.height /  CGFloat(listQuestions.count)

    }
    
    @objc func loginButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }

}

extension RegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listQuestions.count

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RegistrationTableViewCell
        
        let cellHeight = tableView.frame.size.height /  CGFloat(listQuestions.count) - 2
        cell.setParameters(height: cellHeight, textNamesLabel: listQuestions[indexPath.row])
        
        return cell
    }
    
}

