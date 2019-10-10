//
//  imAddressTableViewCell.swift
//  Xeroe
//
//  Created by Denis Markov on 10/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol ImAddressProtocol {
    func imAddressIsCollection(isCollection: Bool)
}


class imAddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var topSpaceButton: NSLayoutConstraint! {
        didSet {
            topSpaceButton.constant = errorLabel.isHidden ? 20 : 60
        }
    }
    
    @IBOutlet weak var checkCollectionAddressButton: CheckButton! {
        didSet {
            checkCollectionAddressButton.checkedImage = #imageLiteral(resourceName: "checkedImage")
            checkCollectionAddressButton.uncheckedImage = #imageLiteral(resourceName: "uncheckedImage")
            checkCollectionAddressButton.addTarget(self, action: #selector(checkCollectionAddressButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var checkDeliveryAddressButton: CheckButton! {
        didSet {
            checkDeliveryAddressButton.checkedImage = #imageLiteral(resourceName: "checkedImage")
            checkDeliveryAddressButton.uncheckedImage = #imageLiteral(resourceName: "uncheckedImage")
            checkDeliveryAddressButton.addTarget(self, action: #selector(checkDeliveryAddressButtonTap), for: .touchUpInside)
        }
    }

    
    var delegate: ImAddressProtocol?
    
    @objc func checkCollectionAddressButtonTap() {
            checkDeliveryAddressButton.isChecked = checkCollectionAddressButton.isChecked
            delegate?.imAddressIsCollection(isCollection: checkCollectionAddressButton.isChecked)
    }
    
    @objc func checkDeliveryAddressButtonTap() {
            checkCollectionAddressButton.isChecked = checkDeliveryAddressButton.isChecked
            delegate?.imAddressIsCollection(isCollection: checkCollectionAddressButton.isChecked)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func uncheckAddress() {
        errorLabel.isHidden = false
    }
    
}
