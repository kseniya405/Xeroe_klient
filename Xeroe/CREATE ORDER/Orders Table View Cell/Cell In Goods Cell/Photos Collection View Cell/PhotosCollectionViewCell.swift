//
//  AddPhotosCollectionViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 8/12/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!

    func setOrderImage(image: UIImage) {
        photoImage.image = image
    }
}
