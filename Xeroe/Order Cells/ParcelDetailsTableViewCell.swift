//
//  ParcelDetailsTableViewCell.swift
//  Xeroe
//
//  Created by Denis Markov on 10/11/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol ParcelDetailsTableViewCellProtocol {
    func setDescription(description: String)
}


class ParcelDetailsTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var headerLabel: UILabel!{
        didSet {
            headerLabel.setLabelStyle(textLabel: parcelDetails, fontLabel: UIFont(name: robotoMedium, size: 18), colorLabel: .darkText)
        }
    }
    
    @IBOutlet weak var descriptionTextView: VerticallyCenteredTextView!
    
    @IBOutlet weak var provideDetailsLabel: UILabel!{
        didSet {
             provideDetailsLabel.setLabelStyle(textLabel: provideDescription, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: errorColor)
        }
    }
    
    var delegate: ParcelDetailsTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        provideDetailsLabel.isHidden = true
    }
    
    
    func setParameters(details: String){
        descriptionTextView.delegate = self
        descriptionTextView.text = details.isEmpty ? descriptionOnTheParcel : details
        descriptionTextView.textColor = details.isEmpty ? lightGrayTextColor : blackTextColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        provideDetailsLabel.isHidden = true
        textView.layer.borderColor = darkBlue.cgColor

        if textView.text == descriptionOnTheParcel {
            textView.text =  ""
            textView.textColor = blackTextColor
            return
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.setDescription(description: textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = lightGrayBackgroundColor.cgColor

        guard let text = textView.text, !text.isEmpty else {
            textView.text = descriptionOnTheParcel
            textView.textColor = lightGrayTextColor
            delegate?.setDescription(description: "")
            return
        }
        
        if text == descriptionOnTheParcel {
            textView.text =  ""
            textView.textColor = blackTextColor
            delegate?.setDescription(description: "")
            return
        }
        delegate?.setDescription(description: textView.text)

    }
    
    func errordetails(showError: Bool) {
        if showError {
            provideDetailsLabel.isHidden = false
        }
    }
    
}


fileprivate let textFieldCornerRadius: CGFloat = 4


class VerticallyCenteredTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func awakeFromNib() {
        self.layer.borderColor = lightGrayBackgroundColor.cgColor
        self.layer.cornerRadius = textFieldCornerRadius
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.textColor = blackTextColor
    }
    
}
