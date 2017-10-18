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
        self.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
    }
    
    func initWithTimetable(model: TimetableModel){
        timetableModelObject = model

        self.ClassTypeLabel.text = timetableModelObject?.classType != nil ? timetableModelObject?.classType! : "(Не указано)";
        self.StartTimeLabel.text = timetableModelObject?.classStartTime != nil ? timetableModelObject?.classStartTime! : "-:-";
        self.EndTimeLabel.text = timetableModelObject?.classEndTime != nil ? timetableModelObject?.classEndTime! : "-:-";
        self.SubjectNameLabel.text = timetableModelObject?.classSubject != nil ? timetableModelObject?.classSubject! : "(Не указано)";
        self.TeacherLabel.text = timetableModelObject?.classTeacher != nil ? timetableModelObject?.classTeacher! : nil;
        self.PlaceLabel.text = timetableModelObject?.classPlace != nil ? timetableModelObject?.classPlace! : nil;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
