//
//  AddPhotoTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol AddPhotoTableViewCellDelegate {
    func addImageCall(cell: PhotosCollectionViewCell)
}

class AddPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var addPhotosLable: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagePicker: ImagePicker!
    
    var delegate: AddPhotoTableViewCellDelegate?
    
    fileprivate let thumbnailSize = CGSize(width: 94.0, height: 94.0)
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photo")
    }
    
}

extension AddPhotoTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotosCollectionViewCell
        cell.photoImage.image = indexPath.row == 0 ? UIImage(named: "default_photo") : UIImage(named: "add_photo")
        return cell
        
    }
    
    
}

extension AddPhotoTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectCell = collectionView.cellForItem(at: indexPath)  as! PhotosCollectionViewCell
        delegate?.addImageCall(cell: selectCell)
        
    }
}

extension AddPhotoTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return thumbnailSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}





