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
    var customAppLook = CustomApplicationLook()
    
    var sepLine: UIView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sepLine = UIView(frame: self.frame)
        self.contentView.addSubview(sepLine!)
        
        self.backgroundColor = CustomApplicationLook.getUnderLayerColor()
        //self.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        self.ClassTypeLabel.textColor = UIColor.white
        self.StartTimeLabel.textColor = customAppLook.mainTextColor
        self.EndTimeLabel.textColor = customAppLook.subTextColor
        self.SubjectNameLabel.textColor = customAppLook.mainTextColor
        self.TeacherLabel.textColor = customAppLook.subTextColor
        self.PlaceLabel.textColor = customAppLook.subTextColor
    }
    
    func initWithTimetable(model: TimetableModel){
        timetableModelObject = model

        self.ClassTypeLabel.text = timetableModelObject?.classType != nil ? timetableModelObject?.classType! : "(Не указано)";
        self.StartTimeLabel.text = timetableModelObject?.classStartTime != nil ? timetableModelObject?.classStartTime! : "-:-";
        self.EndTimeLabel.text = timetableModelObject?.classEndTime != nil ? timetableModelObject?.classEndTime! : "-:-";
        self.SubjectNameLabel.text = timetableModelObject?.classSubject != nil ? timetableModelObject?.classSubject! : "(Не указано)";
        self.TeacherLabel.text = timetableModelObject?.classTeacher != nil ? timetableModelObject?.classTeacher!.name : nil;
        self.PlaceLabel.text = timetableModelObject?.classPlace != nil ? timetableModelObject?.classPlace! : nil;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let square = CGRect(
            origin: CGPoint(x: 15, y: 1),
            size: CGSize(width: self.frame.width - 30, height: 0.5))
        
        sepLine?.frame = square
        sepLine?.layer.borderWidth = 0.5
        sepLine?.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
