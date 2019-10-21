//
//  PaymentsViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 10/21/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var numberCard: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
