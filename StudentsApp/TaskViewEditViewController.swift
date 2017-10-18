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
    
    @IBOutlet weak var TaskShortNameField: UITextView!
    
    
    @IBOutlet weak var TaskSubjectField: UITextView!
    
    @IBOutlet weak var TaskDateField: UITextView!
    
    
    @IBOutlet weak var TaskDescriptionField: UITextView!
    
    
    @IBOutlet weak var TaskPriorityField: UITextView!
    
    
    @IBOutlet weak var TaskStatusField: UITextView!
    
    
    var taskModelObject: TaskModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.TaskShortNameField.text = taskModelObject?.taskNameShort
        self.TaskDescriptionField.text = taskModelObject?.taskDescription
        self.TaskSubjectField.text = taskModelObject?.taskSubject
        self.TaskDateField.text = taskModelObject?.taskDate?.stringFromDate()
        self.TaskStatusField.text = taskModelObject?.taskStatus?.description
        self.TaskPriorityField.text = taskModelObject?.taskPriority?.description
        
        
        self.TaskDescriptionField.isEditable = false
        self.TaskShortNameField.isEditable = false
        self.TaskSubjectField.isEditable = false
        self.TaskDateField.isEditable = false
        self.TaskStatusField.isEditable = false
        self.TaskPriorityField.isEditable = false
        
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
        
        self.TaskDescriptionField.isEditable = true
        self.TaskShortNameField.isEditable = true
        self.TaskSubjectField.isEditable = true
        self.TaskDateField.isEditable = true
        self.TaskStatusField.isEditable = true
        self.TaskPriorityField.isEditable = true
            self.TaskDescriptionField.textColor = UIColor.green
        
        self.EditButton.isHidden = true
        self.DoneButton.isHidden = false
        
        
        
    }
   
    
    @IBAction func DoneButtonPressed(_ sender: Any) {
        
        self.TaskDescriptionField.isEditable = false
        self.TaskShortNameField.isEditable = false
        self.TaskSubjectField.isEditable = false
        self.TaskDateField.isEditable = false
        self.TaskStatusField.isEditable = false
        self.TaskPriorityField.isEditable = false
            self.TaskDescriptionField.textColor = UIColor.red
        
        self.DoneButton.isHidden = true
        self.EditButton.isHidden = false
    }
    
}
