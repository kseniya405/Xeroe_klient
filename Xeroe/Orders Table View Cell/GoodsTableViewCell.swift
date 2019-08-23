//
//  GoodsTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class GoodsTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionsView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var addPhotoDelegate: AddPhotoTableViewCellDelegate?
    
    
    fileprivate var products = ["PRODUCT 1", "ADD +"]
    fileprivate let thumbnailSizeProduct = CGSize(width: 108.0, height: 48.0)
    fileprivate let thumbnailSizeAdd = CGSize(width: 75.0, height: 48.0)
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 2.0)
    
    fileprivate let selectCellColorBackground = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1)
    fileprivate let deselectCellColorBackground = UIColor(red: 0.93, green: 0.94, blue: 0.94, alpha: 1)
    fileprivate let deselectCellColorText = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
    
    let questionsWithTextField = ["Name what you want to deliver", "Describe what you want to deliver"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionsView.dataSource = self
        collectionsView.delegate = self
        collectionsView.register(UINib(nibName: "ChooseProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "product")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DataDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "data")
        tableView.register(UINib(nibName: "AddPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "photoCollection")
        tableView.register(UINib(nibName: "DimensionsTableViewCell", bundle: nil), forCellReuseIdentifier: "dimensions")
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1).cgColor
        tableView.layer.masksToBounds = true
        tableView.allowsSelection = false
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// dataSource about collectionView of product toggle buttons
extension GoodsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ChooseProductCollectionViewCell
        if indexPath.row == numProduct {
            cell.isSelected = true
        }
        if cell.isSelected {
            cell.setParameters(backgroundColor: selectCellColorBackground, labelColor: .white, labelText: products[indexPath.row])
        } else {
            cell.setParameters(backgroundColor: deselectCellColorBackground, labelColor: deselectCellColorText, labelText: products[indexPath.row])
        }
        return cell
    }
}

    extension GoodsTableViewCell: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            if indexPath.row == products.count - 1 {
                return thumbnailSizeAdd
            }
            return thumbnailSizeProduct
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }
    }

extension GoodsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.row == products.count - 1) {
            products.insert("PRODUCT \(products.count)", at: products.count - 1)
            collectionView.reloadData()
            return
        }
        numProduct = indexPath.row
        let selectCell = collectionsView.cellForItem(at: indexPath)  as! ChooseProductCollectionViewCell
        selectCell.setParameters(backgroundColor: selectCellColorBackground, labelColor: .white, labelText: products[indexPath.row])
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectCell = collectionsView.cellForItem(at: indexPath)  as! ChooseProductCollectionViewCell
        deselectCell.setParameters(backgroundColor: deselectCellColorBackground, labelColor: deselectCellColorText, labelText: products[indexPath.row])

    }
}

extension GoodsTableViewCell: UITableViewDelegate {
    
}

extension GoodsTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as! DataDeliveryTableViewCell
            cell.setParameters(questionsLabel: questionsWithTextField[indexPath.row])
            orderData.products[numProduct].name = cell.answerTextField.text
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as! DataDeliveryTableViewCell
            cell.setParameters(questionsLabel: questionsWithTextField[indexPath.row])
            orderData.products[numProduct].description = cell.answerTextField.text
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCollection", for: indexPath) as! AddPhotoTableViewCell
            
            cell.delegate = addPhotoDelegate
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dimensions", for: indexPath) as! DimensionsTableViewCell
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "dimensions", for: indexPath)
        }

        
    }
    
    
}
