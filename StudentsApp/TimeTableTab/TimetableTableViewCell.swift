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
    @IBOutlet weak var ParityLabel: UILabel!
    
    var EditMode: Bool = false
    var timetableModelObject: TimetableModel?
    let customAppLook = CustomApplicationLook()
    
    var sepLine: UIView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sepLine = UIView(frame: self.frame)
        self.contentView.addSubview(sepLine!)
        
        ParityLabel.isHidden = true
        
        customAppLook.managedLayersContext.append(self)
        //self.backgroundColor = customAppLook.underLayerColor
        
        customAppLook.managedMainLablesContext?.append(self.SubjectNameLabel)
        customAppLook.managedMainLablesContext?.append(self.StartTimeLabel)
        //self.SubjectNameLabel.textColor = customAppLook.mainTextColor
        //self.StartTimeLabel.textColor = customAppLook.mainTextColor
        
        customAppLook.managedSubLablesContext?.append(self.EndTimeLabel)
        customAppLook.managedSubLablesContext?.append(self.TeacherLabel)
        customAppLook.managedSubLablesContext?.append(self.PlaceLabel)
        //self.EndTimeLabel.textColor = customAppLook.subTextColor
        //self.TeacherLabel.textColor = customAppLook.subTextColor
        //self.PlaceLabel.textColor = customAppLook.subTextColor
        
        customAppLook.updateManagedContext()

        self.ClassTypeLabel.textColor = UIColor.white
    }
    
    func initWithTimetable(model: TimetableModel){
        timetableModelObject = model
        
        if (EditMode) {
            if (self.timetableModelObject?.classDate != nil) {
                ParityLabel.isHidden = false
                ParityLabel.text = self.timetableModelObject?.classDate?.stringFromDate()
            }
            else {
                if (self.timetableModelObject?.parity != nil) {
                    if (self.timetableModelObject?.parity)! {
                        ParityLabel.isHidden = false
                        ParityLabel.text = "Нечет"
                    }
                    else {
                        ParityLabel.isHidden = false
                        ParityLabel.text = "Чет"
                    }
                }
            }
        }
        
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
