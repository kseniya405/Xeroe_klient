//
//  CompanyDetailViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/6/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierBackScreen = "ContainerViewController"
fileprivate let identifierNextScreen = "ShippingAgrinentViewController"


class FoundUserDetailViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!{
        didSet {
            backButton.addTarget(self, action: #selector(noButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var idRecipient: UILabel!
    @IBOutlet weak var nameRecipient: UILabel!
    @IBOutlet weak var addressRecipient: UILabel!
    @IBOutlet weak var available: UILabel!
    
    @IBOutlet weak var noButton: ButtonWithCornerRadius! {
        didSet {
            noButton.layer.borderColor = basicBlueColor.cgColor
            noButton.layer.borderWidth = 1
            noButton.addTarget(self, action: #selector(noButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var yesButton: ButtonWithCornerRadius!{
        didSet {
            yesButton.layer.borderColor = basicBlueColor.cgColor
            yesButton.addTarget(self, action: #selector(yesButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var foundUserPhotoImage: UIImageView!
    
    var clientDataDictionary: [String: Any] = [:]


    override func viewDidLoad() {
        super.viewDidLoad()
        let foundUserData = ClientData(dictionary: clientDataDictionary)
        idRecipient.text = "# \(clientDataDictionary["xeroeid"] as? String ?? "")"
        nameRecipient.text = foundUserData.email
        
        guard let urlAvatar: String = clientDataDictionary["avatar"] as? String else { return }
        foundUserPhotoImage.getImageFromUrl(url: "http://xeroe.kinect.pro:8091/\(urlAvatar)")
    }
    
    @objc func noButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierBackScreen) as! ContainerViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func yesButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifierNextScreen) as! ShippingAgrinentViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }

}