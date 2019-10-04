//
//  RegistrationViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierCell = "RegistrationTableViewCell"
fileprivate let identifierButtonCell = "ButtonTableViewCell"
fileprivate let identifierLoginVC = "LoginViewController"
fileprivate let sizeFontButton: CGFloat = 13

class RegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    struct cellData {
        var nameCell: String
        var errorLabelCell: String
        var cellIsEmpty: Bool
    }
    let arrayDataCells = [cellData(nameCell: firstName, errorLabelCell: enterFirstName, cellIsEmpty: true),
                          cellData(nameCell: lastName, errorLabelCell: enterLastName, cellIsEmpty: true),
                          cellData(nameCell: email, errorLabelCell: enterEmail, cellIsEmpty: true),
                          cellData(nameCell: mobileNumber, errorLabelCell: enterMobileNumber, cellIsEmpty: true),
                          cellData(nameCell: password, errorLabelCell: enterPassword, cellIsEmpty: true),
                          cellData(nameCell: confirmPassword, errorLabelCell: enterConfirmPassword, cellIsEmpty: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: identifierCell, bundle: nil), forCellReuseIdentifier: identifierCell)
        tableView.register(UINib(nibName: identifierButtonCell, bundle: nil), forCellReuseIdentifier: identifierButtonCell)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
    }
    
    @objc func loginButtonTap() {
        self.dismiss()
    }
    
}

extension RegistrationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataCells.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case arrayDataCells.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierButtonCell, for: indexPath) as! ButtonTableViewCell
            cell.setParameters(text: register, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: .white, backgroundColor: darkBlue)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! RegistrationTableViewCell
            if indexPath.row < arrayDataCells.count {
                cell.setParameters(placeholder: arrayDataCells[indexPath.row].nameCell, errorText: arrayDataCells[indexPath.row].errorLabelCell)
            }
            return cell
        }
        
    }
    
    
    
}

extension RegistrationViewController: ButtonDelegate {
    func registerButtonTap() {
        var isOk = true
        for item in 0...arrayDataCells.count {
            
            if arrayDataCells[item].cellIsEmpty {
                isOk = false
                let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: IndexPath(row: item, section: 0)) as! RegistrationTableViewCell
                cell.pleaseEnterDataLable.isHidden = true
            }
            
        }
        
        if isOk {
            print("ok")
        }
    }
    
    
}
