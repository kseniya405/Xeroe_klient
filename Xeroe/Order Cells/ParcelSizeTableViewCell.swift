//
//  ParcelSizeTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/16/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let sizeFont: CGFloat = 12
fileprivate let identifierCollectionViewCell = "ParcelSizeTypeCollectionViewCell"
fileprivate let identifierTableViewCell = "LimitedSizeTableViewCell"


class ParcelSizeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.setLabelStyle(textLabel: parcelSize, fontLabel: UIFont(name: robotoMedium, size: 18), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var parcelTypeCollectionView: UICollectionView!
    @IBOutlet weak var parcelTypeTableView: UITableView!
    @IBOutlet weak var chooseParcelSize: UILabel! {
        didSet{
            chooseParcelSize.setLabelStyle(textLabel: chooseProvideSize, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: errorColor)
        }
    }
    
    struct sizeType {
        var imageType: String?
        var nameType: String?
        var sizeType: [String]?
        var sizeLimit: [String]?
    }
    var checkSize: Int?
    
    
    var thumbnailSizeAdd = CGSize(width: 76.0, height: 136)
    let sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    
    let dataSize = [sizeType(imageType: "envelopeSize", nameType: envelope, sizeType: [small, medium, large], sizeLimit: [envelopeSSize, envelopeMSize, envelopeLSize]),
                    sizeType(imageType: "packageSize", nameType: package, sizeType: [small, medium, large], sizeLimit: [packageSSize, packageMSize, packageLSize]),
                    sizeType(imageType: "bulkyitemSize", nameType: bulkyItem, sizeType: [large, xlarge], sizeLimit: [bulkyItemLSize, bulkyItemXlSize])]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        parcelTypeCollectionView.delegate = self
        parcelTypeCollectionView.dataSource = self
        parcelTypeCollectionView.register(UINib(nibName: identifierCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: identifierCollectionViewCell)
        
        parcelTypeTableView.delegate = self
        parcelTypeTableView.dataSource = self
        parcelTypeTableView.register(UINib(nibName: identifierTableViewCell, bundle: nil), forCellReuseIdentifier: identifierTableViewCell)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ParcelSizeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSize.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCollectionViewCell, for: indexPath) as! ParcelSizeTypeCollectionViewCell
        if indexPath.row < dataSize.count {
            cell.setParameters(imageName: dataSize[indexPath.row].imageType ?? "" , typeSize: dataSize[indexPath.row].nameType ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3 - sectionInsets.left * 3
        thumbnailSizeAdd.width = width
        return thumbnailSizeAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectCell = collectionView.cellForItem(at: indexPath)  as! DeliveryTypeCollectionViewCell
//        
//        let image = selectCell.logoDeliveryType.image?.withRenderingMode(.alwaysTemplate)
//        selectCell.logoDeliveryType.image = image
//        selectCell.logoDeliveryType.tintColor = .white
//        selectCell.logoDeliveryType.backgroundColor = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1)
//        selectCell.logoDeliveryType.layer.borderColor = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1).cgColor
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let deselectCell = collectionView.cellForItem(at: indexPath)  as! DeliveryTypeCollectionViewCell
//        deselectCell.defaultParameters(type: indexPath.row)
//    }
    
}

extension ParcelSizeTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSize[checkSize ?? 0].sizeType?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierTableViewCell, for: indexPath) as! LimitedSizeTableViewCell
        
        return cell
    }
    
    
}

