//
//  TimeTableViewCell.swift
//  StudentsApp
//
//  Created by AgentSamogon on 10.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var SubjectLabel: UILabel!
    @IBOutlet weak var TeacherLabel: UILabel!
    @IBOutlet weak var ClassTImeLabel: UILabel!
    @IBOutlet weak var ClassroomLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
