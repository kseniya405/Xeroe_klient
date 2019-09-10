//
//  OrderViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/9/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierGoodsCell = "GoodsTableViewCell"
fileprivate let identifierPaymentMethodCell = "PaymentMethodTableViewCell"
fileprivate let identifierClientDataCell = "ClientDataTableViewCell"
fileprivate let identifierOptionsCell = "OptionsTableViewCell"
fileprivate let identifierDeliveryTypeCell = "DeliveryTypeTableViewCell"
fileprivate let identifierHeader = "HeaderOrderTableView"

fileprivate let identifierGoToBack = "ShippingAgrinentViewController"

class OrderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var imagePicker: ImagePicker!
    var imagePickCell: PhotosCollectionViewCell?

    var thisOrderData = ConfirmOrderByCreator()
    var currentProductNum: Int = 0
    
    var clientDataDictionary: [String: Any] = [:]
    var isDelivery: Bool = false
    
    var productCellsArray: [String] = ["PRODUCT 1", addProductElement]

    struct sectionData {
        let section: String
        let typeOfNib: String
    }
    
    let sections = [
        sectionData(section: sectionGoods, typeOfNib: identifierGoodsCell),
        sectionData(section: sectionPaymentMethod, typeOfNib: identifierPaymentMethodCell),
        sectionData(section: sectionSenderData, typeOfNib: identifierClientDataCell),
        sectionData(section: sectionRecipientData, typeOfNib: identifierClientDataCell),
        sectionData(section: sectionOptions, typeOfNib: identifierOptionsCell),
        sectionData(section: sectionDeliveryType, typeOfNib: identifierDeliveryTypeCell)
    ]
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 0.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        for section in sections {
            tableView.register(UINib(nibName: section.typeOfNib, bundle: nil), forCellReuseIdentifier: section.typeOfNib)
        }
        tableView.register(UINib.init(nibName: identifierHeader, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: identifierHeader)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifierHeader) as! HeaderOrderTableView
        
        let sectionNumberIsZero = section == 0
        headerView.goodsLabel.isHidden = !sectionNumberIsZero
        headerView.namesLabel.isHidden = sectionNumberIsZero
        headerView.noteLabel.isHidden = !sectionNumberIsZero
        headerView.namesLabel.text = sections[section].section
        
        headerView.viewBackground.layer.shadowColor = shadowColor.cgColor
        headerView.viewBackground.layer.shadowOpacity = 1
        headerView.viewBackground.layer.shadowRadius = 2
        headerView.viewBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 69 : 52
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! GoodsTableViewCell
            cell.addPhotoDelegate = self
            cell.goodsCellDelegate = self
            cell.setDataCell(currentProduct: thisOrderData.products[currentProductNum], arrayCellsProduct: productCellsArray)
            print(currentProductNum, " ", productCellsArray)

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! PaymentMethodTableViewCell
            cell.delegate = self
            return cell
        case 2, 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! ClientDataTableViewCell
            
            let isSender = isDelivery ? indexPath.section == 2 : indexPath.section == 3
            let id = (isSender ? UserProfile.shared.xeroeId : clientDataDictionary["xeroeid"] as? String) ?? "Wrong data"
            let nameUser = (isSender ? UserProfile.shared.email : clientDataDictionary["email"] as? String) ?? "Wrong data"
            let phone = (isSender ? UserProfile.shared.phone : clientDataDictionary["phone"] as? String) ?? "Wrong data"
            let address = isSender ? "27 Old Gloucester Street, London WC1N" : "11 - 59 Hight Rd, East Finchley, London N2 8AW"
            
            let urlAvatar: String
            if isSender {
                guard let avatar = UserProfile.shared.avatar else { return cell }
                urlAvatar = avatar
            } else {
                guard let avatar = clientDataDictionary["avatar"] as? String else { return cell }
                urlAvatar = avatar
            }
            
            cell.setParameters(id: id, name: nameUser, phone: phone, address: address, avatar: urlAvatar)
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! OptionsTableViewCell
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! DeliveryTypeTableViewCell
            cell.delegate = self
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: sections[0].typeOfNib, for: indexPath)
        }
    }
    
    
    
}

extension OrderViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imagePickCell?.photoImage.image = image
    }
}

extension OrderViewController: AddPhotoTableViewCellDelegate {
    func addImageCall(cell: PhotosCollectionViewCell) {
        imagePickCell = cell
        self.imagePicker.present(from: cell)
    }
}

extension OrderViewController: GoodsCellDelegate, PaymentMethodTableViewCellDelegate, DeliveryTypeTableViewCellDelegate {

    func confirmButtonTap() {
        guard let id = UserProfile.shared.userableId else {  return }
        print(id)
        RestApi().createOrder(idClient: id){ (isOk) in
            DispatchQueue.main.async {
                print(isOk)
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "AgreementTimerViewController") as! AgreementTimerViewController
        initialViewController.orderViewController = self
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    func setDeliveryType(type: Int?) {
        thisOrderData.delivery_type = type
    }
    
    func setPaymentMethod(isCreditCard: Bool) {
        if isCreditCard {
            thisOrderData.payment_method = "credit_card"
        }
    }
    
    func setNumProduct(numProduct: Int) {
        currentProductNum = numProduct
        thisOrderData.products[currentProductNum].id = numProduct + 1
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func setArrayProductCells(array: [String]) {
        productCellsArray = array
    }
    
    func addProductCell() {
        productCellsArray.insert("PRODUCT \(productCellsArray.count)", at: productCellsArray.count - 1)
        print(productCellsArray)
        tableView.reloadData()
    }
    
    func addProduct(){
        thisOrderData.products.append(Product())
    }
    
    func setNameDeliver(nameDeliver: String) {
        thisOrderData.products[currentProductNum].name = nameDeliver
    }
    
    func setDescribeDeliver(describeDeliver: String) {
        thisOrderData.products[currentProductNum].description = describeDeliver
    }
    
    func setWidthDeliver(width: Int?) {
        thisOrderData.products[currentProductNum].width = width ?? 1
    }
    
    func setLengthDeliver(length: Int?) {
        thisOrderData.products[currentProductNum].length = length ?? 1
    }
    
    func setHeightDeliver(height: Int?) {
        thisOrderData.products[currentProductNum].height = height ?? 1
    }
    
    func setWeightDeliver(weight: Int?) {
        thisOrderData.products[currentProductNum].weight = weight ?? 1
    }
    
}
