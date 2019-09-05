//
//  RegistrationViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierCell = "RegistrationTableViewCell"
fileprivate let identifierLoginVC = "LoginViewController"


class RegistrationViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var fbButton: ButtonWithCornerRadius!
    @IBOutlet weak var gButton: ButtonWithCornerRadius!
    @IBOutlet weak var signUpButton: ButtonWithCornerRadius!
    @IBOutlet weak var loginButton: ButtonWithCornerRadius! {
        didSet {
            loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        }
    }
    
    let listQuestions = [username, email, phoneNumber, password, confirmPassword]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: identifierCell, bundle: nil), forCellReuseIdentifier: identifierCell)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false

    }
    
    @objc func loginButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierLoginVC) as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }

}

extension RegistrationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listQuestions.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! RegistrationTableViewCell
        cell.setParameters(textNamesLabel: listQuestions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height /  CGFloat(listQuestions.count)
    }

}

