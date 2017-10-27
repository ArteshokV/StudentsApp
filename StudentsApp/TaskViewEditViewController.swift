//
//  TaskViewEditViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 12.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskViewEditViewController: UIViewController {
    
    
    @IBOutlet weak var DoneButton: UIButton!
    
    @IBOutlet weak var EditButton: UIButton!
    var counter: Int!
    
    @IBOutlet weak var TaskShortNameLabel: UILabel!
    
    
    @IBOutlet weak var TaskSubjectLabel: UILabel!
    
    @IBOutlet weak var TaskDateLabel: UILabel!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var TaskDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var TaskPriorityLabel: UILabel!
    
    
    @IBOutlet weak var TaskStatusLabel: UILabel!
    
    
    var taskModelObject: TaskModel?
    var rounedView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackGroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 1)
        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.005)
        //navigationController?.navigationBar.titleTextAttributes = NSForegroundColorAttributeName: UIColor.red
        //self.navigationController?.navigationBar.tintColor = UIColor.red
        //self.navigationController?.navigationBar.barTintColor = UIColor.clear
        
        
        self.TaskShortNameLabel.text = taskModelObject?.taskNameShort
        self.TaskDescriptionLabel.text = taskModelObject?.taskDescription
        print ("\( self.view.frame.width) ")
        print ("\( TaskDescriptionLabel.frame.width) ")
        print ("\( TaskDescriptionLabel.frame.height) ")
        self.TaskSubjectLabel.text = taskModelObject?.taskSubject
        self.TaskDateLabel.text = taskModelObject?.taskDate?.stringFromDate()
        self.TaskStatusLabel.text = taskModelObject?.taskStatus?.description
        self.TaskPriorityLabel.text = taskModelObject?.taskPriority?.description
        
        TaskDescriptionLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        TaskDateLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        TaskShortNameLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        TaskSubjectLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        TaskStatusLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        TaskPriorityLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        TaskDescriptionLabel.layer.cornerRadius = 10
        TaskDateLabel.layer.cornerRadius = 25
        TaskShortNameLabel.layer.cornerRadius = 35
        TaskSubjectLabel.layer.cornerRadius = 15
        TaskStatusLabel.layer.cornerRadius = 5
        TaskPriorityLabel.layer.cornerRadius = 5
       
        headerLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        headerLabel.layer.cornerRadius = 5
        /*
        self.TaskDescriptionLabel.isEditable = false
        self.TaskShortNameLabel.isEditable = false
        self.TaskSubjectLabel.isEditable = false
        self.TaskDateLabel.isEditable = false
        self.TaskStatusLabel.isEditable = false
        self.TaskPriorityLabel.isEditable = false
        */
        self.DoneButton.isHidden = true
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*    func getSubview (label:UILabel) -> UIView {
        rounedView = UIView(frame: label.frame)
        rounedView?.layer.borderColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25).cgColor
        rounedView?.layer.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25).cgColor
        let roundedViewWidth = label.frame.width
        let roundedViewHeight = label.frame.height
        
        let frameOfRoundedView = CGRect(x:0, y:0, width:roundedViewWidth - 15, height:roundedViewHeight)
        
        
        
        rounedView?.layer.masksToBounds = false
        rounedView?.layer.cornerRadius = label.frame.width * 0.01
        rounedView?.layer.borderWidth = 1.5
            
            //Настройка тени
        rounedView?.layer.shadowOffset = CGSize(width:-2, height:2)
        rounedView?.layer.shadowOpacity = 1
            
            //rounedView!.backgroundColor = UIColor.lightGray
        rounedView?.frame = frameOfRoundedView
        return rounedView!
    } */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func EditButtonPressed(_ sender: Any) {
     /*
        self.TaskDescriptionField.isEditable = true
        self.TaskShortNameField.isEditable = true
        self.TaskSubjectField.isEditable = true
        self.TaskDateField.isEditable = true
        self.TaskStatusField.isEditable = true
        self.TaskPriorityField.isEditable = true
            self.TaskDescriptionField.textColor = UIColor.green
        */
        self.EditButton.isHidden = true
        self.DoneButton.isHidden = false
        
        
        
    }
   
    
    @IBAction func DoneButtonPressed(_ sender: Any) {
    /*
        self.TaskDescriptionField.isEditable = false
        self.TaskShortNameField.isEditable = false
        self.TaskSubjectField.isEditable = false
        self.TaskDateField.isEditable = false
        self.TaskStatusField.isEditable = false
        self.TaskPriorityField.isEditable = false
            self.TaskDescriptionField.textColor = UIColor.red
       */
        self.DoneButton.isHidden = true
        self.EditButton.isHidden = false
    }
    
}
