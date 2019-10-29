//
//  OrderDetailsViewController.swift
//  Xeroe
//
//  Created by Denis Markov on 10/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let numCell = 9
fileprivate let imCell = "imAddressTableViewCell"
fileprivate let clientCell = "ClientTableViewCell"
fileprivate let deliveryCell = "deliveryTableViewCell"
fileprivate let parcelDetailsCell = "ParcelDetailsTableViewCell"
fileprivate let parcelSizeCell = "ParcelSizeTableViewCell"
fileprivate let parcelValueCell = "ParcelValueTableViewCell"
fileprivate let photoCell = "PhotoTableViewCell"
fileprivate let paymentDetailsCell = "PaymentDetailsTableViewCell"
fileprivate let disclaimerCell = "DisclaimerTableViewCell"

fileprivate let nextViewControllerIdentifier = "ContainerViewController"

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var labelBar: UILabel! {
        didSet {
            labelBar.setLabelStyle(textLabel: orderDetails, fontLabel: UIFont(name: robotoMedium, size: sizeFontBarLabel), colorLabel: .white)
        }
    }
    @IBOutlet weak var resetFormButton: UIButton! {
        didSet {
            resetFormButton.addTarget(self, action: #selector(resetFormButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    var clientIsSender = true
    var inputSenderAddress = "Here will be the sender address"
    var inputDeliveryAddress = "Here will be the delivery address"
    var order = OrderData()
    var isCheck = false
    var imagePicker: ImagePicker?
    var imagePickCell: PhotoTableViewCell?
    var allInput = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: imCell, bundle: nil), forCellReuseIdentifier: imCell)
        tableView.register(UINib(nibName: clientCell, bundle: nil), forCellReuseIdentifier: clientCell)
        tableView.register(UINib(nibName: parcelDetailsCell, bundle: nil), forCellReuseIdentifier: parcelDetailsCell)
        tableView.register(UINib(nibName: parcelSizeCell, bundle: nil), forCellReuseIdentifier: parcelSizeCell)
        tableView.register(UINib(nibName: parcelValueCell, bundle: nil), forCellReuseIdentifier: parcelValueCell)
        tableView.register(UINib(nibName: photoCell, bundle: nil), forCellReuseIdentifier: photoCell)
        tableView.register(UINib(nibName: paymentDetailsCell, bundle: nil), forCellReuseIdentifier: paymentDetailsCell)
        tableView.register(UINib(nibName: disclaimerCell, bundle: nil), forCellReuseIdentifier: disclaimerCell)
        
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    @objc func resetFormButtonTap() {
        let alert = UIAlertController(title: "Reset Form", message: ("Are you sure you want to reset the form?"), preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.order = OrderData()
            self.isCheck = false
            self.tableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.reloadData()
            }
        }))
        
        // show the alert
        self.present(alert, animated: false, completion: .none)
    }
    
}

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCell
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
                order.collectionData.mobileNumber = UserProfile.shared.phone
                cell.setParameters(header: header, address: inputSenderAddress, name: order.collectionData.name ?? "", mobileNumber: order.collectionData.mobileNumber ?? "", isSender: isSender, errorName: isCheck && (order.collectionData.name?.isEmpty ?? true), errorMobileNumber: isCheck && (order.collectionData.mobileNumber?.isEmpty ?? true))
            } else {
                cell.setParameters(header: header, address: inputDeliveryAddress, name: order.deliveryData.name ?? "", mobileNumber: order.deliveryData.mobileNumber ?? "", isSender: isSender, errorName: isCheck && (order.deliveryData.name?.isEmpty ?? true), errorMobileNumber: isCheck && (order.deliveryData.mobileNumber?.isEmpty ?? true))
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelDetailsCell, for: indexPath) as! ParcelDetailsTableViewCell
            cell.delegate = self
            cell.setParameters(details: order.parselDetails, showError: isCheck && order.parselDetails.isEmpty)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelSizeCell, for: indexPath) as! ParcelSizeTableViewCell
            cell.errorSize(showError: isCheck && order.parcelSize == nil)
            cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: parcelValueCell, for: indexPath) as! ParcelValueTableViewCell
            cell.delegate = self
            cell.setParameters(value: order.parcelValue, showError: isCheck && (order.parcelValue == nil || order.parcelValue == 0))
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: photoCell, for: indexPath) as! PhotoTableViewCell
            cell.delegate = self
            cell.setParameters(photo: order.photo, showError: isCheck && order.photo == nil)
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: paymentDetailsCell, for: indexPath) as! PaymentDetailsTableViewCell
            cell.setParameters(paymentSystem: UserProfile.shared.paymentsSystem, endCardNumber: UserProfile.shared.endCardNumber)
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: disclaimerCell, for: indexPath) as! DisclaimerTableViewCell
            cell.delegate = self
            cell.setParameters(isChecked: order.isChecked, showError: isCheck && !order.isChecked)
            return cell
        default:
            debugPrint("something wrong in tableView.dataSource")
            return UITableViewCell()
        }
    }
}

extension OrderDetailsViewController: ImAddressDelegate {
    func imAddressIsCollection(isCollection: Bool) {
        clientIsSender = isCollection
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)], with: .none)
        tableView.beginUpdates()
        self.updateViewConstraints()
        tableView.endUpdates()
    }
}

extension OrderDetailsViewController: ClientTableViewCellDelegate {
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

extension OrderDetailsViewController: ParcelDetailsTableViewCellDelegate {
    func setDescription(description: String) {
        order.parselDetails = description
    }
}

extension OrderDetailsViewController: ParcelSizeTableViewCellDelegate {
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
            imagePickCell?.setParameters(photo: photo, showError: false)
            order.photo = photo
            tableView.beginUpdates()
            self.updateViewConstraints()
            tableView.endUpdates()
            isCheck = false
            
        }
        
    }
}

extension OrderDetailsViewController: PhotoTableViewCellDelegate {
    
    func addImageCell(cell: PhotoTableViewCell) {
        imagePickCell = cell
        self.imagePicker?.present(from: cell)
    }
}

extension OrderDetailsViewController: DisclaimerTableViewCellDelegate {
    func getPriceTap() {
        getPriceButtonTap()
    }
    
    func isChecked(isChecked: Bool) {
        order.isChecked = isChecked
        isCheck = false
    }
    
    @objc func getPriceButtonTap() {
        
        allInput = true
        
        isCheck = true
        var row = clientIsSender ? 1 : 2
        checkFields(condition: order.collectionData.name?.isEmpty ?? true, row: row)
        
        row = clientIsSender ? 2 : 1
        checkFields(condition: order.deliveryData.name?.isEmpty ?? true, row: row)
        checkFields(condition: order.deliveryData.mobileNumber?.isEmpty ?? true, row: row)
        checkFields(condition: order.parselDetails.isEmpty, row: 3)
        checkFields(condition: order.parcelSize == nil, row: 4)
        checkFields(condition: order.parcelValue == nil || order.parcelValue == 0, row: 5)
        checkFields(condition: order.photo == nil, row: 6)
        checkFields(condition: !order.isChecked, row: 8)
        
        tableView.beginUpdates()
        self.updateViewConstraints()
        tableView.endUpdates()
        
        if allInput {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: nextViewControllerIdentifier) as! ContainerViewController
            initialViewController.identifier = "SearchDriverViewController"
            self.navigationController?.pushViewController(initialViewController, animated: false)
        }
        allInput = true
    }
    
    fileprivate func checkFields(condition: Bool, row: Int) {
        if condition {
            tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            allInput = false
        }
    }
}
