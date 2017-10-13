//
//  TimetableTableViewCell.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 11.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TimetableTableViewCell: UITableViewCell {
    @IBOutlet weak var ClassTypeLabel: UILabel!
    @IBOutlet weak var StartTimeLabel: UILabel!
    @IBOutlet weak var EndTimeLabel: UILabel!
    @IBOutlet weak var SubjectNameLabel: UILabel!
    @IBOutlet weak var TeacherLabel: UILabel!
    @IBOutlet weak var PlaceLabel: UILabel!
    
    var timetableModelObject: TimetableModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initWithTimetable(model: TimetableModel){
        timetableModelObject = model
        self.ClassTypeLabel.text = timetableModelObject?.classType
        self.StartTimeLabel.text = timetableModelObject?.classStartTime
        self.EndTimeLabel.text = timetableModelObject?.classEndTime
        self.SubjectNameLabel.text = timetableModelObject?.classSubject
        self.TeacherLabel.text = timetableModelObject?.classTeacher
        self.PlaceLabel.text = timetableModelObject?.classPlace
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
