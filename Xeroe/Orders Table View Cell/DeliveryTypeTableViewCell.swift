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
    @IBOutlet weak var confirmButton: ButtonWithCornerRadius!
    
    fileprivate var thumbnailSizeAdd = CGSize(width: 76.0, height: 136)
    private let sectionInsets = UIEdgeInsets(top: 0,
                                             left: 20,
                                             bottom: 0,
                                             right: 17)

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
        let width = collectionView.frame.width/3 - sectionInsets.left
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
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectCell = collectionView.cellForItem(at: indexPath)  as! DeliveryTypeCollectionViewCell
        deselectCell.defaultParameters(type: indexPath.row)
    }
}
