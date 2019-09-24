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
    

    func setData(typeOfProblem: String, isSelected: Bool) {
        self.typeOfProblem.text = typeOfProblem
        let backgroundColor = isSelected ? cianColor : .white
        let fillingColor = isSelected ? .white : blackTextColor
        chooseColors(typeOfProblem: typeOfProblem, backgroundColor: backgroundColor, fillingColor: fillingColor)
    }
    
    func chooseColors(typeOfProblem: String, backgroundColor: UIColor, fillingColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.typeOfProblem.textColor = fillingColor
    }
    
}
