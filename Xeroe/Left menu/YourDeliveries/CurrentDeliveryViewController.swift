//
//  CurrentDeliveryViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 10/24/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "DeliveryDataTableViewCell"
fileprivate let buttonCellIdentifier = "ReportAnIssueTableViewCell"

class CurrentDeliveryViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var labelBar: UILabel! {
        didSet {
            labelBar.setLabelStyle(textLabel: delivery + "#", fontLabel: UIFont(name: robotoMedium, size: sizeFontBarLabel), colorLabel: .white)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    struct DataCell {
        var title: String
        var value0: String
        var value1: String?
    }
    
    var allCells: [DataCell]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: buttonCellIdentifier, bundle: nil), forCellReuseIdentifier: buttonCellIdentifier)
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    func setDeliveryData(data: DeliveryData) {
        labelBar?.text = (labelBar.text ?? "#") + String(data.number)
        allCells = [DataCell(title: journeyStatus, value0: data.status),
                    DataCell(title: collectedFrom, value0: data.collectedAddress, value1: data.collectedAddress),
                    DataCell(title: deliveredTo, value0: data.deliveryName, value1: data.deliveryAddress),
                    DataCell(title: deliveryCost, value0: data.cost),
                    DataCell(title: orderPlaced, value0: data.date),
                    DataCell(title: orderDelivered, value0: data.date),
                    DataCell(title: payment, value0: String(data.payment)) ]
    }


}

extension CurrentDeliveryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allCells?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataCells = allCells, indexPath.row <= dataCells.count else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case dataCells.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: buttonCellIdentifier, for: indexPath) as! ReportAnIssueTableViewCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DeliveryDataTableViewCell
            cell.setParameters(title: dataCells[indexPath.row].title, value0: dataCells[indexPath.row].value0, value1: dataCells[indexPath.row].value1)
            return cell
        }
    }
    
    
}

extension CurrentDeliveryViewController: ReportButtonDelegate {
    func goToReportScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
}
