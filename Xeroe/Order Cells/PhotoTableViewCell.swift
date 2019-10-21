//
//  PhotoTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/18/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol PhotoTableViewCellDelegate {
    func addImageCell(cell: PhotoTableViewCell)
}

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.setLabelStyle(textLabel: photo, fontLabel: UIFont(name: robotoMedium, size: 18), colorLabel: .darkText)
        }
    }
    @IBOutlet weak var PhotoImage: UIImageView!
    @IBOutlet weak var addPhotoButton: ButtonWithCornerRadius! {
        didSet {
            addPhotoButton.setParameters(text: addPhoto, font: UIFont(name: robotoRegular, size: 17), tintColor: .white, backgroundColor: darkBlue)
            addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var provideImage: UILabel! {
        didSet{
            provideImage.setLabelStyle(textLabel: pleaseProvideImage, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: errorColor)
        }
    }
    
    var delegate: PhotoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func addPhotoButtonTap() {
        provideImage.isHidden = true
        delegate?.addImageCell(cell: self)
    }
    
    func setParameters(photo: UIImage?) {
        if let image = photo {
            PhotoImage.image = image
            PhotoImage.isHidden = false
            provideImage.isHidden = true
            addPhotoButton.setTitle(useADifferentPhoto, for: .normal)
        } else {
            PhotoImage.isHidden = true
            provideImage.isHidden = true
            addPhotoButton.setTitle(addPhoto, for: .normal)
        }
    }
    
    func errorImage(showError: Bool) {
        if showError {
            provideImage.isHidden = false
            PhotoImage.isHidden = true
        }
    }
}
