//
//  ProblemTableViewCell.swift
//  Xeroe
//
//  Created by Денис Марков on 9/20/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class ProblemTableViewCell: UITableViewCell {

    @IBOutlet weak var typeOfProblem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func setData(typeOfProblem: String) {
        self.typeOfProblem.text = typeOfProblem
    }

    
}
