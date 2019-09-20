//
//  ReportViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/19/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var typeOfProblemTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: ButtonWithCornerRadius!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    



}

//extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //
//    }

    

