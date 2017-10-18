//
//  TaskTableViewCell.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 11.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBAction func DoneButtonPressed(_ sender: UIButton) {
        print("Pressed that task is done")
    }
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var TopSubjectLabel: UILabel!
    @IBOutlet weak var MiddleDescriptionLabel: UILabel!
    @IBOutlet weak var BottomEdgeDateLabel: UILabel!
    
    var taskModelObject: TaskModel?
    var activityModelObject: ActivitiesModel?
    var rounedView: UIView?
    var cellColor: UIColor?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rounedView = UIView(frame: self.frame)
        
        self.contentView.addSubview(rounedView!)
        self.contentView.sendSubview(toBack: rounedView!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithTask(model: TaskModel, forSortingType: String){
        taskModelObject = model
        
        self.MiddleDescriptionLabel.text = taskModelObject?.taskNameShort != nil ? taskModelObject?.taskNameShort! : "(Не указано)";
        
        switch taskModelObject?.taskPriority {
        case 0?:
            cellColor = UIColor.init(red: 14, green: 0, blue: 0, alpha: 0.1)
            break
        case 1?:
            cellColor = UIColor.init(red: 25, green: 25, blue: 0, alpha: 0.2)
            break
        case 2?:
            cellColor = UIColor.init(red: 0, green: 15, blue: 0, alpha: 0.1)
            break
        default:
            cellColor = UIColor.lightGray
            break
        }
        
        let subjectString = taskModelObject?.taskSubject != nil ? taskModelObject?.taskSubject! : "(Не указано)";
        let dateString = taskModelObject?.taskDate != nil ? taskModelObject?.taskDate!.stringFromDate() : "(Не указано)";
        
        switch forSortingType {
        case "Сроки":
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = ""
            self.rounedView?.backgroundColor = cellColor
            break
        case "Предметы":
            self.TopSubjectLabel.text = ""
            self.BottomEdgeDateLabel.text = dateString
            self.rounedView?.backgroundColor = cellColor
            break
        case "Приоритет":
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = dateString
            rounedView?.backgroundColor = UIColor.lightGray
            break
        default:
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = dateString
            self.rounedView?.backgroundColor = cellColor
            break
        }
        
    }
    
    func initWithActivity(model: ActivitiesModel, forSortingType: String){
        activityModelObject = model
        
        self.MiddleDescriptionLabel.text = activityModelObject?.activityNameShort != nil ? activityModelObject?.activityNameShort! : "(Не указано)";
        cellColor = UIColor.blue
        
        
        let subjectString = activityModelObject?.activitySubject != nil ? activityModelObject?.activitySubject! : "(Не указано)";
        let dateString = activityModelObject?.activityDate != nil ? activityModelObject?.activityDate!.stringFromDate() : "(Не указано)";
        
        switch forSortingType {
        case "Сроки":
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = ""
            self.rounedView?.backgroundColor = cellColor
            break
        case "Предметы":
            self.TopSubjectLabel.text = ""
            self.BottomEdgeDateLabel.text = dateString
            self.rounedView?.backgroundColor = cellColor
            break
        default:
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = dateString
            self.rounedView?.backgroundColor = cellColor
            break
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let insetsFromLeftRightSides: CGFloat = 5.0
        let insetsFromUpDownSides:CGFloat = 5.0
        let roundedViewWidth = self.frame.width - insetsFromLeftRightSides*2
        let roundedViewHeight = self.frame.height - insetsFromUpDownSides*2
        
        let frameOfRoundedView = CGRect(x:insetsFromLeftRightSides, y:insetsFromUpDownSides, width:roundedViewWidth, height:roundedViewHeight)
        
        if(rounedView!.frame != frameOfRoundedView){
            rounedView!.layer.masksToBounds = false
            rounedView!.layer.cornerRadius = self.frame.height/2-2

            //Настройка тени
            rounedView!.layer.shadowOffset = CGSize(width:-1, height:2)
            rounedView!.layer.shadowOpacity = 0.2
            
            //rounedView!.backgroundColor = UIColor.lightGray
            rounedView!.frame = frameOfRoundedView
        }
    }
}
