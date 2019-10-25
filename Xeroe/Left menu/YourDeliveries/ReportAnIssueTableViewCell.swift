//
//  ReportAnIssueTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 10/25/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

protocol ReportButtonDelegate {
    func goToReportScreen()
}

class ReportAnIssueTableViewCell: UITableViewCell {

    @IBOutlet weak var reportAnIssueButton: ButtonWithCornerRadius!   {
             didSet {
                 reportAnIssueButton.setParameters(text: getPrice, font: UIFont(name: robotoRegular, size: 17), tintColor: .white, backgroundColor: errorButtonColor)
                 reportAnIssueButton.addTarget(self, action: #selector(reportAnIssueButtonTap), for: .touchUpInside)
             }
         }
    
    var delegate: ReportButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func reportAnIssueButtonTap() {
        delegate?.goToReportScreen()
    }
    
}
