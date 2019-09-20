//
//  ViewEndDeliveryForRecipient.swift
//  Xeroe
//
//  Created by Денис Марков on 9/18/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class EndDeliveryForRecipientView: UIView {

    @IBOutlet weak var showQRButton: UIButton! {
        didSet {
            showQRButton.addTarget(self, action: #selector(showQRButtonTap), for: .touchUpInside)
        }
    }
    
    @objc func showQRButtonTap() {
        //
    }

}
