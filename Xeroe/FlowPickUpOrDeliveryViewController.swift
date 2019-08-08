//
//  flowPickUpOrDeliveryViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/8/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class FlowPickUpOrDeliveryViewController: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!{
        didSet {
            buttonBack.addTarget(self, action: #selector (buttonBackTap), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @objc func buttonBackTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RecipientDetailViewController") as! RecipientDetailViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
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
