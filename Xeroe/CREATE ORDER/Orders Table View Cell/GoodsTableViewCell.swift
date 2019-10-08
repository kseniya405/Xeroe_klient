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
    func setNumProduct(numProduct: Int)
    func setNameDeliver(nameDeliver: String)
    func setDescribeDeliver(describeDeliver: String)
    func setWidthDeliver(width: Int?)
    func setLengthDeliver(length: Int?)
    func setHeightDeliver(height: Int?)
    func setWeightDeliver(weight: Int?)
    
    func setArrayProductCells(array: [String])
    func addProductCell()
}


class GoodsTableViewCell: UITableViewCell{

    @IBOutlet weak var collectionsView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var addPhotoDelegate: AddPhotoTableViewCellDelegate?
    var goodsCellDelegate: GoodsCellDelegate?
    
    var numSelectProduct = 0
    var productCells = [""]
    
    let thumbnailSizeProduct = CGSize(width: widthCollectionCellProduct, height: heightCollectionCell)
    let thumbnailSizeAdd = CGSize(width: widthCollectionCellProduct, height: heightCollectionCell)
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
    var selectedIndexPath : IndexPath?
    
    let questionsWithTextField = [nameDeliver, describeDeliver]
    
    var currentProduct = [Product()]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.register(UINib(nibName: dataDeliveryIdentifier, bundle: nil), forCellReuseIdentifier: dataDeliveryIdentifier)
        tableView.register(UINib(nibName: addPhotoIdentifier, bundle: nil), forCellReuseIdentifier: addPhotoIdentifier)
        tableView.register(UINib(nibName: dimensionsIdentifier, bundle: nil), forCellReuseIdentifier: dimensionsIdentifier)
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = cianColor.cgColor
        tableView.layer.masksToBounds = true
        tableView.allowsSelection = false
        collectionsView.dataSource = self
        collectionsView.delegate = self
        collectionsView.register(UINib(nibName: chooseProductIdentifier, bundle: nil), forCellWithReuseIdentifier: chooseProductIdentifier)
    }
    
    func setDataCell(currentProduct: [Product], arrayCellsProduct: [String], numProduct: Int) {
        self.currentProduct = currentProduct
        self.productCells = arrayCellsProduct
        self.numSelectProduct = numProduct
        collectionsView.reloadData()
    }
    
    
}

// dataSource about collectionView of product toggle buttons
extension GoodsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chooseProductIdentifier, for: indexPath) as! ChooseProductCollectionViewCell
        if indexPath.item < productCells.count {
            if indexPath.item == numSelectProduct {
                cell.setParameters(backgroundColor: cianColor, labelColor: .white, labelText: productCells[indexPath.item])
            } else {
                cell.defaultParameters(labelText: productCells[indexPath.item])
            }
        }
        return cell
    }
}

extension GoodsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row == productCells.count - 1 ? thumbnailSizeAdd : thumbnailSizeProduct
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

extension GoodsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.row == productCells.count - 1) {
            goodsCellDelegate?.addProduct()
            goodsCellDelegate?.addProductCell()
            return
        }
        collectionView.reloadData()
        tableView.reloadData()
        numSelectProduct = indexPath.row
        goodsCellDelegate?.setNumProduct(numProduct: indexPath.row)
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
            let inputAnswer = indexPath.row == 0 ? currentProduct[numSelectProduct].name : currentProduct[numSelectProduct].description
            cell.setParameters(questionsLabel: questionsWithTextField[indexPath.row], answerText: inputAnswer ?? "")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: addPhotoIdentifier, for: indexPath) as! AddPhotoTableViewCell
            cell.delegate = addPhotoDelegate            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: dimensionsIdentifier, for: indexPath) as! DimensionsTableViewCell
            cell.setParameters(width: String(currentProduct[numSelectProduct].width), length: String(currentProduct[numSelectProduct].length), height: String(currentProduct[numSelectProduct].height), weight: String(currentProduct[numSelectProduct].weight))
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension GoodsTableViewCell: DimensionsTableViewCellDelegate, DataDeliveryTableViewCellDelegate {
    
    func setWidthDeliver(width: Int) {
        goodsCellDelegate?.setWidthDeliver(width: width)
        currentProduct[numSelectProduct].width = width
    }
    
    func setLengthDeliver(length: Int) {
        goodsCellDelegate?.setLengthDeliver(length: length)
        currentProduct[numSelectProduct].length = length
    }
    
    func setHeightDeliver(height: Int) {
        goodsCellDelegate?.setHeightDeliver(height: height)
        currentProduct[numSelectProduct].height = height
    }
    
    func setWeightDeliver(weight: Int) {
        goodsCellDelegate?.setWeightDeliver(weight: weight)
        currentProduct[numSelectProduct].weight = weight
    }
    
    func setDataDeliveryName(name: String) {
        goodsCellDelegate?.setNameDeliver(nameDeliver: name)
        currentProduct[numSelectProduct].name = name
    }
    
    func setDataDeliveryDescription(description: String) {
        goodsCellDelegate?.setDescribeDeliver(describeDeliver: description)
        currentProduct[numSelectProduct].description = description
    }
}