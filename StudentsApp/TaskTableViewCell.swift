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
        
        self.MiddleDescriptionLabel.text = taskModelObject?.taskNameShort
        
        switch taskModelObject?.taskPriority {
        case 0?:
            cellColor = UIColor.green
            break
        case 1?:
            cellColor = UIColor.yellow
            break
        case 2?:
            cellColor = UIColor.red
            break
        default:
            cellColor = UIColor.lightGray
            break
        }
        
        switch forSortingType {
        case "Сроки":
            self.TopSubjectLabel.text = taskModelObject?.taskSubject
            self.BottomEdgeDateLabel.text = ""
            self.rounedView?.backgroundColor = cellColor
            break
        case "Предметы":
            self.TopSubjectLabel.text = ""
            self.BottomEdgeDateLabel.text = taskModelObject?.taskDate?.stringFromDate()
            self.rounedView?.backgroundColor = cellColor
            break
        case "Приоритет":
            self.TopSubjectLabel.text = taskModelObject?.taskSubject
            self.BottomEdgeDateLabel.text = taskModelObject?.taskDate?.stringFromDate()
            rounedView?.backgroundColor = UIColor.lightGray
            break
        default:
            self.TopSubjectLabel.text = taskModelObject?.taskSubject
            self.BottomEdgeDateLabel.text = taskModelObject?.taskDate?.stringFromDate()
            self.rounedView?.backgroundColor = cellColor
            break
        }
        
    }
    
    func initWithActivity(model: ActivitiesModel, forSortingType: String){
        activityModelObject = model
        
        self.MiddleDescriptionLabel.text = activityModelObject?.activityNameShort
        cellColor = UIColor.blue
        
        switch forSortingType {
        case "Сроки":
            self.TopSubjectLabel.text = activityModelObject?.activitySubject
            self.BottomEdgeDateLabel.text = ""
            self.rounedView?.backgroundColor = cellColor
            break
        case "Предметы":
            self.TopSubjectLabel.text = ""
            self.BottomEdgeDateLabel.text = activityModelObject?.activityDate?.stringFromDate()
            self.rounedView?.backgroundColor = cellColor
            break
        default:
            self.TopSubjectLabel.text = activityModelObject?.activitySubject
            self.BottomEdgeDateLabel.text = activityModelObject?.activityDate?.stringFromDate()
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
