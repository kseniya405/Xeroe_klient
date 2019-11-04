//
//  imAddressTableViewCell.swift
//  Xeroe
//
//  Created by Denis Markov on 10/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol ImAddressDelegate {
    func imAddressIsCollection(isCollection: Bool)
//    func addressIsCheck(isCheck: Bool)
}

fileprivate let sizeErrorFont: CGFloat = 14

fileprivate let checkedImageButton = "checkedImage"
fileprivate let uncheckedImageButton = "uncheckedImage"


class imAddressTableViewCell: UITableViewCell {
        
    @IBOutlet weak var checkCollectionAddressButton: CheckButton! {
        didSet {
            checkCollectionAddressButton.setParametersImage(checkedImage: UIImage(named: checkedImageButton), uncheckedImage: UIImage(named: uncheckedImageButton))
            checkCollectionAddressButton.addTarget(self, action: #selector(checkCollectionAddressButtonTap), for: .touchUpInside)
            
        }
    }
    @IBOutlet weak var imCollectionAddressLabel: UILabel! {
        didSet {
            imCollectionAddressLabel.setLabelStyle(textLabel: collectionAddress, fontLabel: UIFont(name: robotoRegular, size: sizeFontBasic), colorLabel: grayTextColor)
        }
    }
    
    @IBOutlet weak var checkDeliveryAddressButton: CheckButton! {
        didSet {
            checkDeliveryAddressButton.setParametersImage(checkedImage: UIImage(named: checkedImageButton), uncheckedImage: UIImage(named: uncheckedImageButton))
            checkDeliveryAddressButton.addTarget(self, action: #selector(checkDeliveryAddressButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var imDeliveryAddressLabel: UILabel! {
        didSet {
            imDeliveryAddressLabel.setLabelStyle(textLabel: deliveryAddress, fontLabel: UIFont(name: robotoRegular, size: sizeFontBasic), colorLabel: grayTextColor)
        }
    }
    
    var delegate: ImAddressDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func checkCollectionAddressButtonTap() {
        checkCollectionAddressButton.isChecked = true
        changeChoose(otherButton: checkDeliveryAddressButton, isCollectionAddress: true)
    }
    
    
    @objc func checkDeliveryAddressButtonTap() {
        checkDeliveryAddressButton.isChecked = true
        changeChoose(otherButton: checkCollectionAddressButton, isCollectionAddress: false)
    }
    
    fileprivate func changeChoose(otherButton: CheckButton, isCollectionAddress: Bool) {
        otherButton.isChecked = false
        delegate?.imAddressIsCollection(isCollection: isCollectionAddress)
    }
    

}
