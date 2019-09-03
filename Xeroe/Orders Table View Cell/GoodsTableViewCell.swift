//
//  GoodsTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let chooseProductIdentifier = "ChooseProductCollectionViewCell"
fileprivate let dataDeliveryIdentifier = "DataDeliveryTableViewCell"
fileprivate let addPhotoIdentifier = "AddPhotoTableViewCell"
fileprivate let dimensionsIdentifier = "DimensionsTableViewCell"

fileprivate let widthCollectionCellProduct = 108.0
fileprivate let widthCollectionCellAdd = 75.0
fileprivate let heightCollectionCell = 48.0

protocol GoodsCellDelegate {
    func addProduct()
    func setNameDeliver(nameDeliver: String, numProduct: Int)
    func setDescribeDeliver(describeDeliver: String, numProduct: Int)
    func setWidthDeliver(width: Int?, numProduct: Int)
    func setLengthDeliver(length: Int?, numProduct: Int)
    func setHeightDeliver(height: Int?, numProduct: Int)
    func setWeightDeliver(weight: Int?, numProduct: Int)
}

class GoodsTableViewCell: UITableViewCell{

    @IBOutlet weak var collectionsView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var addPhotoDelegate: AddPhotoTableViewCellDelegate?
    var goodsCellDelegate: GoodsCellDelegate?
    var numProduct: Int = 0
    var productDataArray = [Product()]
    
    var products = ["PRODUCT 1", addProduct]
    let thumbnailSizeProduct = CGSize(width: widthCollectionCellProduct, height: heightCollectionCell)
    let thumbnailSizeAdd = CGSize(width: widthCollectionCellProduct, height: heightCollectionCell)
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
    
    let questionsWithTextField = [nameDeliver, describeDeliver]
    
    var currentName: String = ""
    var currentDescribe: String = ""
    var currentWidth: Int = 1
    var currentLength: Int = 1
    var currentHeight: Int = 1
    var currentWeight: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionsView.dataSource = self
        collectionsView.delegate = self
        collectionsView.register(UINib(nibName: chooseProductIdentifier, bundle: nil), forCellWithReuseIdentifier: chooseProductIdentifier)
        tableView.dataSource = self
        tableView.register(UINib(nibName: dataDeliveryIdentifier, bundle: nil), forCellReuseIdentifier: dataDeliveryIdentifier)
        tableView.register(UINib(nibName: addPhotoIdentifier, bundle: nil), forCellReuseIdentifier: addPhotoIdentifier)
        tableView.register(UINib(nibName: dimensionsIdentifier, bundle: nil), forCellReuseIdentifier: dimensionsIdentifier)
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = backgroundChooseCellColor.cgColor
        tableView.layer.masksToBounds = true
        tableView.allowsSelection = false
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
    }
    
    func setInputData(currentName: String?, currentDescribe: String?, currentWidth: Int?, currentLength: Int?, currentHeight: Int?, currentWeight: Int?) {
        self.currentName = currentName ?? ""
        self.currentDescribe = currentDescribe ?? ""
        self.currentWidth = currentWidth ?? 1
        self.currentLength = currentLength ?? 1
        self.currentHeight = currentHeight ?? 1
        self.currentWeight = currentWeight ?? 1
    }
    
}

// dataSource about collectionView of product toggle buttons
extension GoodsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chooseProductIdentifier, for: indexPath) as! ChooseProductCollectionViewCell
        if indexPath.row == numProduct {
            cell.isSelected = true
        }
        let backgroundColor = cell.isSelected ? backgroundChooseCellColor : productCellOrderTableBackgroundColor
        let labelColor = cell.isSelected ? .white : productCellOrderTableTextColor
        
        cell.setParameters(backgroundColor: backgroundColor, labelColor: labelColor, labelText: products[indexPath.row])
        
        return cell
    }
}

extension GoodsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row == products.count - 1 ? thumbnailSizeAdd : thumbnailSizeProduct
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

extension GoodsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.row == products.count - 1) {
            products.insert("PRODUCT \(products.count)", at: products.count - 1)
            goodsCellDelegate?.addProduct()
            productDataArray.append(Product())
            collectionView.reloadData()
            return
        }
        numProduct = indexPath.row

        let selectCell = collectionsView.cellForItem(at: indexPath)  as! ChooseProductCollectionViewCell
        
        selectCell.setParameters(backgroundColor: backgroundChooseCellColor, labelColor: .white, labelText: products[indexPath.row])
        collectionView.reloadData()
        selectCell.isSelected = true

        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectCell = collectionsView.cellForItem(at: indexPath)  as! ChooseProductCollectionViewCell
        deselectCell.setParameters(backgroundColor: productCellOrderTableBackgroundColor, labelColor: productCellOrderTableTextColor, labelText: products[indexPath.row]) 
    }
}

extension GoodsTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0, 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: dataDeliveryIdentifier, for: indexPath) as! DataDeliveryTableViewCell
            cell.delegate = self
            let inputAnswer = indexPath.row == 0 ? productDataArray[numProduct].name : productDataArray[numProduct].description
            cell.setParameters(questionsLabel: questionsWithTextField[indexPath.row], answerText: inputAnswer ?? "")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: addPhotoIdentifier, for: indexPath) as! AddPhotoTableViewCell
            cell.delegate = addPhotoDelegate            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: dimensionsIdentifier, for: indexPath) as! DimensionsTableViewCell
            cell.setParameters(width: String(productDataArray[numProduct].width), length: String(productDataArray[numProduct].length), height: String(productDataArray[numProduct].height), weight: String(productDataArray[numProduct].weight))
            cell.delegate = self
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: dimensionsIdentifier, for: indexPath)
        }
    }
}

extension GoodsTableViewCell: DimensionsTableViewCellDelegate, DataDeliveryTableViewCellDelegate, OrderViewControllerDelegate {

    func getOrderDataDelivery(confirmOrderByCreator: ConfirmOrderByCreator) -> ConfirmOrderByCreator {
        return confirmOrderByCreator
    }
    
    func setWidthDeliver(width: Int?) {
        goodsCellDelegate?.setWidthDeliver(width: width, numProduct: numProduct)
        productDataArray[numProduct].width = width ?? 1
    }
    
    func setLengthDeliver(length: Int?) {
        goodsCellDelegate?.setLengthDeliver(length: length, numProduct: numProduct)
        productDataArray[numProduct].length = length ?? 1
    }
    
    func setHeightDeliver(height: Int?) {
        goodsCellDelegate?.setHeightDeliver(height: height, numProduct: numProduct)
        productDataArray[numProduct].height = height ?? 1
    }
    
    func setWeightDeliver(weight: Int?) {
        goodsCellDelegate?.setWeightDeliver(weight: weight, numProduct: numProduct)
        productDataArray[numProduct].weight = weight ?? 1
    }
    
    func setDataDeliveryName(name: String) {
        goodsCellDelegate?.setNameDeliver(nameDeliver: name, numProduct: numProduct)
        productDataArray[numProduct].name = name

    }
    
    func setDataDeliveryDescription(description: String) {
        goodsCellDelegate?.setDescribeDeliver(describeDeliver: description, numProduct: numProduct)
        productDataArray[numProduct].description = description
    }
}
