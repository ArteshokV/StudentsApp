//
//  taskTableViewCell.swift
//  StudentsApp
//
//  Created by Admin on 09.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class taskTableViewCell: UITableViewCell {


    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var shortNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
