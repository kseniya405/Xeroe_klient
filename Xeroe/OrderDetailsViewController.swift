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
        isCheck = true
        if order.collectionData.name == nil || order.collectionData.name == "" {
            let indexPath = clientIsSender ? IndexPath(row: 1, section: 0) : IndexPath(row: 2, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        if order.deliveryData.name == nil || order.deliveryData.name == "" {
            let indexPath = clientIsSender ? IndexPath(row: 2, section: 0) : IndexPath(row: 1, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        if order.deliveryData.mobileNumber == nil || order.deliveryData.mobileNumber == "" {
            let indexPath = clientIsSender ? IndexPath(row: 2, section: 0) : IndexPath(row: 1, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        if order.parselDetails.isEmpty {
            let indexPath = IndexPath(row: 3, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        if order.parcelSize == nil {
            let indexPath = IndexPath(row: 4, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        if order.parcelValue == nil || order.parcelValue == 0 {
            let indexPath = IndexPath(row: 5, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        if order.photo == nil{
            let indexPath = IndexPath(row: 6, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
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
    var isCheck = false
    var imagePicker: ImagePicker!
    var imagePickCell: PhotoTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: imCell, bundle: nil), forCellReuseIdentifier: imCell)
        tableView.register(UINib(nibName: clientCell, bundle: nil), forCellReuseIdentifier: clientCell)
        tableView.register(UINib(nibName: parcelDetailsCell, bundle: nil), forCellReuseIdentifier: parcelDetailsCell)
        tableView.register(UINib(nibName: parcelSizeCell, bundle: nil), forCellReuseIdentifier: parcelSizeCell)
        tableView.register(UINib(nibName: parcelValueCell, bundle: nil), forCellReuseIdentifier: parcelValueCell)
        tableView.register(UINib(nibName: photoCell, bundle: nil), forCellReuseIdentifier: photoCell)
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
            cell.errorMobileNumber(showError: isCheck && (cell.mobileNumberTextField.text?.isEmpty ?? true))
            cell.errorName(showError: isCheck && (cell.nameTextField.text?.isEmpty ?? true))
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelDetailsCell, for: indexPath) as! ParcelDetailsTableViewCell
            cell.setParameters(details: order.parselDetails)
            cell.delegate = self
            cell.errordetails(showError: isCheck && order.parselDetails.isEmpty)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelSizeCell, for: indexPath) as! ParcelSizeTableViewCell
            cell.errorSize(showError: isCheck && order.parcelSize == nil)
            cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelValueCell, for: indexPath) as! ParcelValueTableViewCell
            cell.delegate = self
            cell.setParameters(value: order.parcelValue)
            cell.errorValue(showError: isCheck && (order.parcelValue == nil || order.parcelValue == 0))
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: photoCell, for: indexPath) as! PhotoTableViewCell
            cell.delegate = self
            cell.setParameters(photo: order.photo)
            cell.errorImage(showError: isCheck && order.photo == nil)
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
        isCheck = false
    }
    
    func editNumber(inputNumber: String) {
        if clientIsSender {
            order.deliveryData.mobileNumber = inputNumber
        } else {
            order.collectionData.mobileNumber = inputNumber
        }
        isCheck = false
        
    }
    
    
}

extension OrderDetailsViewController: ParcelDetailsTableViewCellProtocol {
    func setDescription(description: String) {
        order.parselDetails = description
        print(order.parselDetails)
    }
    
}

extension OrderDetailsViewController: ParcelSizeTableViewCelldelegate {
    func updateConstraintCell() {
        tableView.beginUpdates()
        self.updateViewConstraints()
        tableView.endUpdates()
    }
    
    func setSize(size: Int) {
        order.parcelSize = size
        isCheck = false
    }
    
}

extension OrderDetailsViewController: ParcelValueDelegate {
    func setParcelValue(value: Int) {
        order.parcelValue = value
        isCheck = false
    }
    
    
}


extension OrderDetailsViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let photo = image {
            imagePickCell?.setParameters(photo: photo)
        }
    }
}

extension OrderDetailsViewController: PhotoTableViewCellDelegate {
    func addImageCall(cell: PhotoTableViewCell) {
        imagePickCell = cell
        self.imagePicker.present(from: cell)
    }
}

