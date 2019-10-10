//
//  OrderDetailsViewController.swift
//  Xeroe
//
//  Created by Denis Markov on 10/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let imCell = "imAddressTableViewCell"
fileprivate let collectionCell = "collectionTableViewCell"
fileprivate let deliveryCell = "deliveryTableViewCell"
fileprivate let parcelDetailsCell = "parcelDetailsTableViewCell"
fileprivate let parcelSizeCell = "parcelSizeTableViewCell"
fileprivate let parcelValueCell = "parcelValueTableViewCell"
fileprivate let photoCell = "photoTableViewCell"
fileprivate let paymentDetailsCell = "paymentDetailsTableViewCell"
fileprivate let disclaimerCell = "disclaimerTableViewCell"


class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var resetFormButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: imCell, bundle: nil), forCellReuseIdentifier: imCell)
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

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: imCell, for: indexPath) as! imAddressTableViewCell
            
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
}
