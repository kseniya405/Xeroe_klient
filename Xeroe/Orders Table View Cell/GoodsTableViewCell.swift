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
    
    
    
    fileprivate var products = ["PRODUCT 1", "ADD +"]
    fileprivate let thumbnailSizeProduct = CGSize(width: 108.0, height: 48.0)
    fileprivate let thumbnailSizeAdd = CGSize(width: 75.0, height: 48.0)
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate let selectCellColorBackground = UIColor(red: 0.18, green: 0.73, blue: 0.93, alpha: 1)
    fileprivate let deselectCellColorBackground = UIColor(red: 0.93, green: 0.94, blue: 0.94, alpha: 1)
    
    let questionsWithTextField = ["Name what you want to deliver", "Describe what you want to deliver"]


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionsView.dataSource = self
        collectionsView.delegate = self
        collectionsView.register(UINib(nibName: "AddProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DataDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "data")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension GoodsTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddProductCollectionViewCell
        cell.labelCell.text = products[indexPath.row]
        if indexPath.row == products.count - 1 {
            cell.backgroundColor = deselectCellColorBackground
        }
        
        return cell
    }
}

extension GoodsTableViewCell : UICollectionViewDelegateFlowLayout {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddProductCollectionViewCell
        if cell.labelCell.text == "ADD +" {
            products[products.count-1] = "PRODUCT \(products.count)"
        }
        cell.backgroundColor = selectCellColorBackground
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddProductCollectionViewCell
        
        cell.backgroundColor = deselectCellColorBackground

    }
}

extension GoodsTableViewCell: UITableViewDelegate {
    
}

extension GoodsTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsWithTextField.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as! DataDeliveryTableViewCell
        cell.questionsLabel.text = questionsWithTextField[indexPath.row]
        return cell
    }
    
    
}
