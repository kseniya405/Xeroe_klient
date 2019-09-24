//
//  ReportViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/19/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let identifierCell = "ProblemTableViewCell"
fileprivate let identifierHeader = "ProblemHeaderTableViewCell"

class ReportViewController: UIViewController {
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var typeOfProblemTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: ButtonWithCornerRadius! {
        didSet {
            submitButton.addTarget(self, action: #selector(submitButtonTap), for: .touchUpInside)
        }
    }
    
    var selectedIndexPath : IndexPath?
    var selectProblem = problemPackageIsWrong
    let listProblems = [problemPackageIsWrong, problemPickUpPersonDidntAnswerCall, problemDropOffPersonDidntAnswerCall, problemPackageIsDamaged]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: identifierCell, bundle: nil), forCellReuseIdentifier: identifierCell)
        tableView.register(UINib.init(nibName: identifierHeader, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: identifierHeader)
        // Do any additional setup after loading the view.
    }
    
    @objc func submitButtonTap() {
        self.dismiss()
    }

}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProblems.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! ProblemTableViewCell
        if indexPath.row < listProblems.count {
            cell.setData(typeOfProblem: listProblems[indexPath.row], isSelected: cell.isSelected)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifierHeader) as! ProblemHeaderTableViewCell
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: ProblemTableViewCell = tableView.cellForRow(at: indexPath)! as! ProblemTableViewCell
        selectProblem = selectedCell.typeOfProblem.text ?? ""
        tableView.reloadData()

        if let previosSelectCell = selectedIndexPath {
            selectedIndexPath = indexPath
            tableView.reloadRows(at: [previosSelectCell], with: .none)
        }
        selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .none)
    }

}

