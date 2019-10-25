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

class RegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var labelBar: UILabel! {
        didSet {
            labelBar.setLabelStyle(textLabel: register, fontLabel: UIFont(name: robotoMedium, size: sizeFontBarLabel), colorLabel: .white)
        }
    }
    
    struct cellData {
        var nameCell: String
        var errorLabelCell: String
        var cellIsEmpty: Bool
    }
    
    var arrayDataCells = [cellData(nameCell: firstName, errorLabelCell: enterFirstName, cellIsEmpty: true),
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
        
    }
    
    @objc func backButtonTap() {
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
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! RegistrationTableViewCell
            if indexPath.row < arrayDataCells.count {
                cell.setParameters(placeholder: arrayDataCells[indexPath.row].nameCell, errorText: arrayDataCells[indexPath.row].errorLabelCell)
                cell.delegate = self
                cell.numCell = indexPath.row
                if indexPath.row > arrayDataCells.count - 3 {
                    cell.visibleButton.isHidden = false
                    cell.answerTextField.isSecureTextEntry = true
                }
            }
            return cell
        }
        
    }
    
}

extension RegistrationViewController: ButtonDelegate, RegistrationCellDelegate {
    func cellIsEmpty(isEmpty: Bool, numCell: Int?) {
        if let item = numCell, item < arrayDataCells.count {
            arrayDataCells[item].cellIsEmpty = isEmpty
        }
    }
    
    func registerButtonTap() {
        var isOk = true
        for item in 0...arrayDataCells.count - 1 {
            
            if arrayDataCells[item].cellIsEmpty {
                isOk = false
                let cell = tableView.cellForRow(at: IndexPath(row: item, section: 0)) as! RegistrationTableViewCell
                cell.pleaseEnterDataLable.isHidden = false
                cell.spaceView.isHidden = true
            }
        }
        
        if isOk {
             self.dismiss()
        }
        
    }
    
    
}
