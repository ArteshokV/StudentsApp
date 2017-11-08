//
//  TaskTapViewCell.swift
//  StudentsApp
//
//  Created by Admin on 27.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskTapViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
     var customAppLook = CustomApplicationLook()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = CustomApplicationLook.getUnderLayerColor()
        self.label.textColor = customAppLook.mainTextColor
         self.selectionStyle = .none
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
