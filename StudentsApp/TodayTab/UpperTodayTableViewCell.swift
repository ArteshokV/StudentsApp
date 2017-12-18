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
    
    let customAppLook = CustomApplicationLook()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.DateLabel.textColor = customAppLook.mainTextColor
        customAppLook.managedMainLablesContext.append(self.DateLabel)
        
        let cust = CustomDateClass()
        DateLabel.text = cust.todayStringWithoutWeekDay() //CustomDateClass.todaysDateString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
