//
//  TaskTableViewCell.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 11.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBAction func CheckPressed(_ sender: Any) {
        print("Pressed that task is done")
        if count == 0 {
            self.rounedView?.backgroundColor = cellColor
            count = 1
        }
        else {
            self.rounedView?.backgroundColor = UIColor.clear
            count = 0
        }
        
    }
    
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var TopSubjectLabel: UILabel!
    @IBOutlet weak var MiddleDescriptionLabel: UILabel!
    @IBOutlet weak var BottomEdgeDateLabel: UILabel!
    @IBOutlet weak var backButton: UIView!
    
    var taskModelObject: TaskModel?
    var activityModelObject: ActivitiesModel?
    var rounedView: UIView?
    var sepLine: UIView?
    var cellColor: UIColor?
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rounedView = UIView(frame: self.frame)
        self.selectionStyle = .none
        sepLine = UIView(frame: self.frame)
        
        // Add the view to the view hierarchy so that it shows up on screen
        self.contentView.addSubview(sepLine!)
        self.backButton.addSubview(rounedView!)
        self.backButton.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithTask(model: TaskModel, forSortingType: String){
        taskModelObject = model
        rounedView?.backgroundColor = UIColor.clear
        self.MiddleDescriptionLabel.text = taskModelObject?.taskNameShort != nil ? taskModelObject?.taskNameShort! : "(Не указано)";
        
        switch taskModelObject?.taskPriority {
        case 0?:
            cellColor = UIColor.init(red: 0, green: 15, blue: 0, alpha: 0.05)
            break
        case 1?:
            cellColor = UIColor.init(red: 25, green: 25, blue: 0, alpha: 0.05)
            break
        case 2?:
            cellColor = UIColor.init(red: 14, green: 0, blue: 0, alpha: 0.05)
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
            self.rounedView?.layer.borderColor = cellColor!.cgColor
            break
        case "Предметы":
            self.TopSubjectLabel.text = ""
            self.BottomEdgeDateLabel.text = dateString
            self.rounedView?.layer.borderColor = cellColor!.cgColor
            break
        case "Приоритет":
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = dateString
            self.rounedView?.layer.borderColor = UIColor.lightGray.cgColor
            
            break
        default:
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = dateString
            self.rounedView?.layer.borderColor = cellColor!.cgColor
            break
        }
        
    }
    
    func initWithActivity(model: ActivitiesModel, forSortingType: String){
        activityModelObject = model
        rounedView?.backgroundColor = UIColor.clear
        self.MiddleDescriptionLabel.text = activityModelObject?.activityNameShort != nil ? activityModelObject?.activityNameShort! : "(Не указано)";
        cellColor = UIColor.white
        
        
        let subjectString = activityModelObject?.activitySubject != nil ? activityModelObject?.activitySubject! : "(Не указано)";
        let dateString = activityModelObject?.activityDate != nil ? activityModelObject?.activityDate!.stringFromDate() : "(Не указано)";
        self.rounedView?.layer.borderColor = UIColor.lightGray.cgColor
        
        switch forSortingType {
        case "Сроки":
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = ""
            
            break
        case "Предметы":
            self.TopSubjectLabel.text = ""
            self.BottomEdgeDateLabel.text = dateString
            //self.rounedView?.layer.borderColor = cellColor!.cgColor
            break
        default:
            self.TopSubjectLabel.text = subjectString
            self.BottomEdgeDateLabel.text = dateString
           // self.rounedView?.layer.borderColor = cellColor!.cgColor
            break
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let square = CGRect(
            origin: CGPoint(x: 15, y: 1),
            size: CGSize(width: self.frame.width - 30, height: 0.5))
        
        sepLine?.frame = square
        sepLine?.layer.borderWidth = 0.5
        sepLine?.layer.borderColor = UIColor.lightGray.cgColor
      
        let roundedViewWidth = self.frame.width * 0.1
        let roundedViewHeight = self.frame.width * 0.1
        
        let frameOfRoundedView = CGRect(x:0, y:0, width:roundedViewWidth, height:roundedViewHeight)
       
        
        if(rounedView!.frame != frameOfRoundedView){
            rounedView!.layer.masksToBounds = false
            rounedView!.layer.cornerRadius = self.frame.width * 0.05
            rounedView!.layer.borderWidth = 1.5

            //Настройка тени
           rounedView!.layer.shadowOffset = CGSize(width:-2, height:2)
           rounedView!.layer.shadowOpacity = 1
            
            //rounedView!.backgroundColor = UIColor.lightGray
            rounedView!.frame = frameOfRoundedView
            
            
            
        }
        
        
    }
}
