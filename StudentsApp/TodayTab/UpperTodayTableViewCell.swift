//
//  UpperTodayTableViewCell.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 19.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class UpperTodayTableViewCell: UITableViewCell {

    @IBOutlet weak var DateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        DateLabel.text = CustomDateClass.todaysDateString()
        print(CustomDateClass.todaysDateString())
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
