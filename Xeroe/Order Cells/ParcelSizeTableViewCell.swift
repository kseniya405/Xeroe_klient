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

protocol ParcelSizeTableViewCelldelegate {
    func updateConstraintCell()
    func setSize(size: Int)
}

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
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    var delegate: ParcelSizeTableViewCelldelegate?
    
    struct sizeType {
        var imageType = ""
        var nameType = ""
        var sizeType = [""]
        var sizeLimit = [""]
    }
    var checkSize = 0
    var indexTable = 0
    
    //    var thumbnailSizeAdd = CGSize(width: 100.0, height: 200)
    let sectionInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 30)
    
    
    let dataSize = [sizeType(imageType: "envelopeSize", nameType: envelope, sizeType: [small, medium, large], sizeLimit: [envelopeSSize, envelopeMSize, envelopeLSize]),
                    sizeType(imageType: "packageSize", nameType: package, sizeType: [small, medium, large], sizeLimit: [packageSSize, packageMSize, packageLSize]),
                    sizeType(imageType: "bulkyItemSize", nameType: bulkyItem, sizeType: [large, xlarge], sizeLimit: [bulkyItemLSize, bulkyItemXlSize])]
    
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
            cell.setParameters(imageName: dataSize[indexPath.row].imageType, typeSize: dataSize[indexPath.row].nameType)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexTable = indexPath.row
        parcelTypeTableView.beginUpdates()
        parcelTypeTableView.reloadData()
        parcelTypeTableView.endUpdates()
        parcelTypeTableView.isHidden = false
        delegate?.updateConstraintCell()
        let selectCell = collectionView.cellForItem(at: indexPath) as! ParcelSizeTypeCollectionViewCell
        selectCell.setBackgroundColor(color: lightGrayBackgroundColor)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectCell = collectionView.cellForItem(at: indexPath)  as! ParcelSizeTypeCollectionViewCell
        deselectCell.setBackgroundColor(color: .white)
        
    }
    
}

extension ParcelSizeTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = false
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierTableViewCell, for: indexPath) as! LimitedSizeTableViewCell
        if indexTable < dataSize.count, indexPath.row < dataSize[indexTable].sizeType.count, indexPath.row < dataSize[indexTable].sizeLimit.count {
            cell.setParameters(title: dataSize[indexTable].sizeType[indexPath.row], value: dataSize[indexTable].sizeLimit[indexPath.row])
        }
        return cell
    }
    
    
}

