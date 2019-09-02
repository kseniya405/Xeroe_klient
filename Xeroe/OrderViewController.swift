//
//  OrderViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/9/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var imagePicker: ImagePicker!
    var imagePickCell: PhotosCollectionViewCell?
    
    
    struct sectionData {
        let section: String
        let typeOfNib: String
    }
    
    let sections = [
        sectionData(section: "GOODS", typeOfNib: "GoodsTableViewCell"),
        sectionData(section: "PAYMENT METHOD", typeOfNib: "PaymentMethodTableViewCell"),
        sectionData(section: "SENDER", typeOfNib: "ClientDataTableViewCell"),
        sectionData(section: "RECIPIENT", typeOfNib: "ClientDataTableViewCell"),
        sectionData(section: "Options", typeOfNib: "OptionsTableViewCell"),
        sectionData(section: "Delivery type", typeOfNib: "DeliveryTypeTableViewCell")
        ]
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 0.0)
    
    var isDelivery: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for section in sections {
            tableView.register(UINib(nibName: section.typeOfNib, bundle: nil), forCellReuseIdentifier: section.typeOfNib)
        }
        tableView.register(UINib.init(nibName: "HeaderOrderTableView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "header")
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)


    }
    
    @objc func backButtonTap() {
        ConfirmOrderByCreator.orderData = ConfirmOrderByCreator()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ShippingAgrinentViewController") as! ShippingAgrinentViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! HeaderOrderTableView
        
        let sectionNumberIsZero = section == 0
        headerView.goodsLabel.isHidden = !sectionNumberIsZero
        headerView.namesLabel.isHidden = sectionNumberIsZero
        headerView.noteLabel.isHidden = !sectionNumberIsZero
        headerView.namesLabel.text = sections[section].section
        
        headerView.viewBackground.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.13).cgColor
        headerView.viewBackground.layer.shadowOpacity = 1
        headerView.viewBackground.layer.shadowRadius = 2
        headerView.viewBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 69
        }
        return 52
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
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! PaymentMethodTableViewCell
                if cell.buttonImage.isChecked {
                    ConfirmOrderByCreator.orderData.payment_method = "credit_card"
                }
                return cell
            case 2, 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! ClientDataTableViewCell
                
                let isSender = isDelivery ? indexPath.section == 2 : indexPath.section == 3
                cell.setParameters(isSender: isSender)
                return cell

            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! OptionsTableViewCell
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].typeOfNib, for: indexPath) as! DeliveryTypeTableViewCell
                
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
