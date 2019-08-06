//
//  ClientDetailViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/5/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ClientDetailViewController: UIViewController {

    
    @IBAction func openViewTwoBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "opensAViewController", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
