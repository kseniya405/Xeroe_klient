//
//  ResultAgreementViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let nextViewControllerIdentifier = "ContainerViewController"

class ResultAgreementViewController: UIViewController {

    
    @IBOutlet weak var navigationBarLabel: UILabel!
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    @IBOutlet weak var okButton: ButtonWithCornerRadius!{
        didSet {
            okButton.layer.borderColor = basicBlueColor.cgColor
            okButton.addTarget(self, action: #selector(okButtonTapIfDenied), for: .touchUpInside)
        }
    }
    
    var isAgreementSuccesful: Bool?
    var orderViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setParameters()
    }
    
    @objc func okButtonTapIfDenied() {
        if isAgreementSuccesful ?? false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: nextViewControllerIdentifier) as! ContainerViewController
            initialViewController.identifier = .searchDriver
            self.navigationController?.pushViewController(initialViewController, animated: false)
        } else {
            self.navigationController?.popToViewController(orderViewController!, animated: false)
        }
        
    }
    
    func setParameters() {
        guard let isSuccesful = isAgreementSuccesful else { return }
        if isSuccesful {
            
        }
        
        let nameResultImage = isSuccesful ? "accept" : "block"
        self.resultImage.image = UIImage(named: nameResultImage)
        self.navigationBarLabel.text = isSuccesful ? agreement : recipientAccepted
        self.resultLabel.text = isSuccesful ? recipientAcceptedYouDelivery : recipientDeniedDelivery
    }

}
