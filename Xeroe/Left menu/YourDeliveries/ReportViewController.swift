//
//  ReportViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/19/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import DropDown

fileprivate let cellIdentifier = "ProblemTableViewCell"

class ReportViewController: UIViewController, UIGestureRecognizerDelegate {
    
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
    
    @IBOutlet weak var selectReasonButton: ButtonWithCornerRadius!  {
        didSet {
            selectReasonButton.setParameters(text: selectReason, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: .gray, backgroundColor: .white, borderColor: .lightGray)
            selectReasonButton.addTarget(self, action: #selector(selectReasonButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var commentTextField: VerticallyCenteredTextView! {
        didSet{
            commentTextField.layer.masksToBounds = true
            commentTextField.layer.cornerRadius = 1
        }
    }
    @IBOutlet weak var leaveMessageLabel: UILabel!
    
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var submitButton: ButtonWithCornerRadius! {
        didSet {
            submitButton.addTarget(self, action: #selector(submitButtonTap), for: .touchUpInside)
        }
    }
    
    let dropDown = DropDown()
    
    var selectedIndexPath : IndexPath?
    var selectProblem = problemPackageIsWrong
    let listProblems = [selectReason, problemPackageIsWrong, unableContactCustomer, unableContactDriver, other]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.delegate = self


        let tap = UITapGestureRecognizer()
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        dropDown.animationEntranceOptions = .transitionCurlDown
        // The view to which the drop down will appear on
        dropDown.anchorView = dropDownView // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = listProblems
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let color: UIColor = index == 0 ? .gray : .darkText
            self.selectReasonButton.setParameters(text: item, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: color, backgroundColor: .white)

        }

    }
    
    @objc func selectReasonButtonTap() {
         dropDown.show()
    }
    
    
    @objc func submitButtonTap() {
        self.dismiss()
    }
    
    @objc func backButtonTap() {
        self.dismiss()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.dropDownView) == false, touch.view?.isDescendant(of: self.selectReasonButton) == false {
            dropDown.hide()
        }
        return true
    }
    
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProblems.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProblemTableViewCell
        if indexPath.row < listProblems.count {
            cell.setData(typeOfProblem: listProblems[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
       textView.text = ""
        textView.textColor = .darkText

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = pleaseLeaveComment
        }
    }

}
