//
//  YourDeliveriesViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 10/23/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "DeliveryTableViewCell"

class YourDeliveriesViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var labelBar: UILabel! {
        didSet {
            labelBar.setLabelStyle(textLabel: yourDeliveries, fontLabel: UIFont(name: robotoMedium, size: sizeFontBarLabel), colorLabel: .white)
        }
    }
    @IBOutlet weak var pricesIncVATLabel: UILabel! {
        didSet {
            pricesIncVATLabel.setLabelStyle(textLabel: pricesIncVat, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: .white)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var listDeliveries: [DeliveryData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeliveries{ (isOk) in
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }

    }
    
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    
    // Decode JSON
    func getDeliveries(callback: @escaping (Bool) -> Void) {
        listDeliveries = []
        guard let url = Bundle.main.url(forResource: "deliveries", withExtension: "json") else {
            debugPrint("File not found")
            callback(false)
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(DeliveryJson.self, from: data)
            listDeliveries = json.deliveries
            callback(true)
        }
        catch {
            callback(false)
            print("Error occured during Parsing", error)
        }
    }
    
}


extension YourDeliveriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listDeliveries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let deliveries = listDeliveries else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DeliveryTableViewCell
        if indexPath.row < deliveries.count {
            cell.setParameters(data: deliveries[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
