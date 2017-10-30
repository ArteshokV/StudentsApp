//
//  TaskEditViewController.swift
//  StudentsApp
//
//  Created by Admin on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskEditViewController: UIViewController {
    
    var taskEditObject: TaskModel?
    
    @IBOutlet weak var PriorityButton: UIButton!
    @IBOutlet weak var DateButton: UIButton!
    @IBOutlet weak var DescriptionText: UITextView!
    @IBOutlet weak var ShortNameText: UITextField!
   
    @IBOutlet weak var SubjectText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SubjectText.text = taskEditObject?.taskSubject
        ShortNameText.text = taskEditObject?.taskNameShort
        DescriptionText.text = taskEditObject?.taskDescription
        DateButton.setTitle(taskEditObject?.taskDate?.stringFromDate(), for: .normal)
        PriorityButton.setTitle(taskEditObject?.taskPriority?.description, for: .normal)
        
       // ShortNameText.sizeThatFits(CGSize)
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

}
