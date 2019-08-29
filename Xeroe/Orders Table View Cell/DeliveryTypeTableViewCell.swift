//
//  DeliveryTypeTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class DeliveryTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var confirmButton: ButtonWithCornerRadius! {
        didSet {
            confirmButton.addTarget(self, action: #selector(confirmButtonTap), for: .touchUpInside)
        }
    }
    
    fileprivate var thumbnailSizeAdd = CGSize(width: 76.0, height: 136)
    private let sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "DeliveryTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "deliveryCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func confirmButtonTap() {
//        let data = ConfirmOrderByCreator.orderData
//   !!!!   add dictionary
//        print(ConfirmOrderByCreator.orderData.asDictionary as Any)

        
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Incomplete order data", message: "Please select a payment method.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.superview?.parentContainerViewController()?.present(alert, animated: true, completion: nil)
    }
    
}

extension DeliveryTypeTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deliveryCell", for: indexPath) as! DeliveryTypeCollectionViewCell
        cell.defaultParameters(type: indexPath.row)
        return cell
    }
}

extension DeliveryTypeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        let width = collectionView.frame.width/3 - sectionInsets.left * 3
        thumbnailSizeAdd.width = width
        return thumbnailSizeAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
}

extension DeliveryTypeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectCell = collectionView.cellForItem(at: indexPath)  as! DeliveryTypeCollectionViewCell
        
        let image = selectCell.logoDeliveryType.image?.withRenderingMode(.alwaysTemplate)
        selectCell.logoDeliveryType.image = image
        selectCell.logoDeliveryType.tintColor = .white
        selectCell.logoDeliveryType.backgroundColor = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1)
        selectCell.logoDeliveryType.layer.borderColor = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1).cgColor
        
        ConfirmOrderByCreator.orderData.delivery_type = indexPath.row + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectCell = collectionView.cellForItem(at: indexPath)  as! DeliveryTypeCollectionViewCell
        deselectCell.defaultParameters(type: indexPath.row)
    }
}
