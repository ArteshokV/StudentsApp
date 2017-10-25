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
    
    
    @IBOutlet weak var TaskDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var TaskPriorityLabel: UILabel!
    
    
    @IBOutlet weak var TaskStatusLabel: UILabel!
    
    
    var taskModelObject: TaskModel?
    
    
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
        self.TaskSubjectLabel.text = taskModelObject?.taskSubject
        self.TaskDateLabel.text = taskModelObject?.taskDate?.stringFromDate()
        self.TaskStatusLabel.text = taskModelObject?.taskStatus?.description
        self.TaskPriorityLabel.text = taskModelObject?.taskPriority?.description
        
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
