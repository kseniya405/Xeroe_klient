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
            selectReasonButton.setParameters(text: selectReason, font: UIFont(name: robotoRegular, size: sizeFontButton), tintColor: .gray, backgroundColor: .white, borderColor: lightGrayBackgroundColor)
            selectReasonButton.addTarget(self, action: #selector(selectReasonButtonTap), for: .touchUpInside)
            selectReasonButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
    }
    @IBOutlet weak var commentTextView: VerticallyCenteredTextView! {
        didSet{
            commentTextView.layer.masksToBounds = true
            commentTextView.layer.cornerRadius = 1
        }
    }
    @IBOutlet weak var leaveMessageLabel: UILabel!  {
           didSet{
               leaveMessageLabel.setLabelStyle(textLabel: pleaseLeaveMessage, fontLabel: UIFont(name: robotoRegular, size: sizeFontError), colorLabel: errorColor)
           }
       }
    
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var reportIssueButton: ButtonWithCornerRadius! {
        didSet {
            reportIssueButton.addTarget(self, action: #selector(reportIssueTap), for: .touchUpInside)
        }
    }
    
    let dropDown = DropDown()
    
    var selectedIndexPath : IndexPath?
    var selectProblem = problemPackageIsWrong
    let listProblems = [selectReason, problemPackageIsWrong, unableContactCustomer, unableContactDriver, other]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self


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
            let color: UIColor = index == 0 ? .gray : blackTextColor
            self.selectReasonButton.setTitle(item, for: .normal)
            self.selectReasonButton.setTitleColor(color, for: .normal)

        }
        

    }
    
    @objc func selectReasonButtonTap() {
         dropDown.show()
    }
    
    
    @objc func reportIssueTap() {
        if let comment = commentTextView.text, !comment.isEmpty, !comment.elementsEqual(pleaseLeaveComment) {
            self.dismiss()
        } else {
            leaveMessageLabel.isHidden = false
        }
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
        textView.text = ""
        textView.textColor = .darkText
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = pleaseLeaveComment
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        leaveMessageLabel.isHidden = true
    }

}
