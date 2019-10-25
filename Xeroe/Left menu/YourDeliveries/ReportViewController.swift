//
//  ReportViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/19/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "ProblemTableViewCell"

class ReportViewController: UIViewController {
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarLabel: UILabel!  {
        didSet {
            topBarLabel.setLabelStyle(textLabel: yourDeliveries, fontLabel: UIFont(name: robotoMedium, size: sizeFontBarLabel), colorLabel: .white)
        }
    }
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var selectReasonButton: ButtonWithCornerRadius!
    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var leaveMessageLabel: UILabel!
    
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
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)

    }
    
    @objc func submitButtonTap() {
        self.dismiss()
    }
    
    @objc func backButtonTap() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProblemTableViewCell
        if indexPath.row < listProblems.count {
            cell.setData(typeOfProblem: listProblems[indexPath.row])
        }
        return cell
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

