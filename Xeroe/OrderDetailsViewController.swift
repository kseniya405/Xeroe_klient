//
//  OrderDetailsViewController.swift
//  Xeroe
//
//  Created by Denis Markov on 10/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let imCell = "imAddressTableViewCell"
fileprivate let clientCell = "ClientTableViewCell"
fileprivate let deliveryCell = "deliveryTableViewCell"
fileprivate let parcelDetailsCell = "ParcelDetailsTableViewCell"
fileprivate let parcelSizeCell = "ParcelSizeTableViewCell"
fileprivate let parcelValueCell = "ParcelValueTableViewCell"
fileprivate let photoCell = "PhotoTableViewCell"
fileprivate let paymentDetailsCell = "PaymentDetailsTableViewCell"
fileprivate let disclaimerCell = "DisclaimerTableViewCell"

fileprivate let userMobileNumber = "+380669962658"

class OrderDetailsViewController: UIViewController {
    @IBOutlet weak var touchMeButton: UIButton! {
        didSet {
            touchMeButton.addTarget(self, action: #selector(touchMeButtonTap), for: .touchUpInside)
        }
    }
    
    @objc func touchMeButtonTap() {
        debugPrint("touchMeButton Tap")
        if order.collectionData.name == nil || order.collectionData.name == "" {
            let indexPath = clientIsSender ? IndexPath(row: 1, section: 0) : IndexPath(row: 2, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ClientTableViewCell
            cell.provideNameLabel.isHidden = false
            
        }
        
        if order.deliveryData.name == nil || order.deliveryData.name == "" {
            let indexPath = clientIsSender ? IndexPath(row: 2, section: 0) : IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ClientTableViewCell
            cell.provideNameLabel.isHidden = false
            
        }
        
        if order.deliveryData.mobileNumber == nil || order.deliveryData.mobileNumber == "" {
            let indexPath = clientIsSender ? IndexPath(row: 2, section: 0) : IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ClientTableViewCell
            cell.provideMobileNumberLabel.isHidden = false
        }
        
        if order.parselDetails.isEmpty {
            let indexPath = IndexPath(row: 3, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ParcelDetailsTableViewCell
            cell.provideDetailsLabel.isHidden = false
        }
        
        tableView.beginUpdates()
        self.updateViewConstraints()
        tableView.endUpdates()
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var resetFormButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var clientIsSender = true
    var inputSenderAddress = ""
    var inputDeliveryAddress = ""
    var order = OrderData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: imCell, bundle: nil), forCellReuseIdentifier: imCell)
        tableView.register(UINib(nibName: clientCell, bundle: nil), forCellReuseIdentifier: clientCell)
        tableView.register(UINib(nibName: parcelDetailsCell, bundle: nil), forCellReuseIdentifier: parcelDetailsCell)
        tableView.register(UINib(nibName: parcelSizeCell, bundle: nil), forCellReuseIdentifier: parcelSizeCell)

    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
}

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: imCell, for: indexPath) as! imAddressTableViewCell
            cell.delegate = self
            return cell
        case 1, 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: clientCell, for: indexPath) as! ClientTableViewCell
            cell.delegate = self
            let isSender = clientIsSender ? indexPath.row == 1 : indexPath.row == 2
            let header = indexPath.row == 1 ? collection : delivery
            if isSender {
                if inputSenderAddress == "" {
                    inputSenderAddress = "Here will be the sender address"
                }
                order.collectionData.mobileNumber = userMobileNumber
                cell.setParameters(header: header, address: inputSenderAddress, name: order.collectionData.name ?? "", mobileNumber: order.collectionData.mobileNumber ?? userMobileNumber, isSender: isSender, enteredName: true, enteredNumber: true)
            } else {
                if inputDeliveryAddress == "" {
                    inputDeliveryAddress = "Here will be the delivery address"
                }
                cell.setParameters(header: header, address: inputDeliveryAddress, name: order.deliveryData.name ?? "", mobileNumber: order.deliveryData.mobileNumber ?? "", isSender: isSender, enteredName: true, enteredNumber: true)
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelDetailsCell, for: indexPath) as! ParcelDetailsTableViewCell
            cell.setParameters(details: order.parselDetails)
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelSizeCell, for: indexPath) as! ParcelSizeTableViewCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension OrderDetailsViewController: ImAddressDelegate {
    func imAddressIsCollection(isCollection: Bool) {
        clientIsSender = isCollection
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)], with: .none)
    }
}

extension OrderDetailsViewController: ClientTableViewCellProtocol {
    func editName(inputName: String, isSender: Bool) {
        if isSender {
            order.collectionData.name = inputName
        } else {
            order.deliveryData.name = inputName
        }
    }
    
    func editNumber(inputNumber: String) {
        if clientIsSender {
            order.deliveryData.mobileNumber = inputNumber
        } else {
            order.collectionData.mobileNumber = inputNumber
        }
    }
    
    
}

extension OrderDetailsViewController: ParcelDetailsTableViewCellProtocol {
    func setDescription(description: String) {
        order.parselDetails = description
        print(order.parselDetails)
    }
    
}
