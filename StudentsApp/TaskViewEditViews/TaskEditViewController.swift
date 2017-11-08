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
    
    @IBOutlet weak var NameShortLabel: UILabel!
    @IBOutlet weak var SubjectLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var HiddenDescription: UITextView!
    @IBOutlet weak var PriorityButton: UIButton!
    @IBOutlet weak var DateButton: UIButton!
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBOutlet weak var NameShortText: UITextView!
    
    @IBOutlet weak var SubjectText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        HiddenDescription.alpha = 0
        HiddenDescription.text = taskEditObject?.taskDescription
        // Do any additional setup after loading the view.
        SubjectText.text = taskEditObject?.taskSubject
        SubjectText.font = UIFont.boldSystemFont(ofSize: 18)
        NameShortText.text = taskEditObject?.taskNameShort
        DescriptionText.text = taskEditObject?.taskDescription
        DateButton.setTitle(taskEditObject?.taskDate?.stringFromDate(), for: .normal)
        PriorityButton.setTitle(taskEditObject?.taskPriority?.description, for: .normal)
     
        if DescriptionText.isFirstResponder {
            print (" khkjk ")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DescriptionText.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @objc func saveChanges() {
        taskEditObject?.taskDescription = self.DescriptionText.text
        taskEditObject?.save()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func doneDescriptionEditing() {
      self.navigationItem.rightBarButtonItem = nil
        self.DescriptionText.text = self.HiddenDescription.text
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.HiddenDescription.alpha = 0
        }, completion: nil)
        
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
            self.SubjectText.alpha = 1
            self.SubjectText.alpha = 1
            self.NameShortText.alpha = 1
            self.DescriptionText.alpha = 1
            self.DateButton.alpha = 1
            self.PriorityButton.alpha = 1
            self.DescriptionLabel.alpha = 1
            self.NameShortLabel.alpha = 1
            self.SubjectLabel.alpha = 1
            
        }, completion: nil)
        
        self.navigationItem.hidesBackButton = false
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
    }
    
    func touchDescription() {
       
        self.navigationItem.hidesBackButton = true
        self.HiddenDescription.becomeFirstResponder()
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.SubjectText.alpha = 0
            self.SubjectText.alpha = 0
            self.NameShortText.alpha = 0
            self.DescriptionText.alpha = 0
            self.DateButton.alpha = 0
            self.PriorityButton.alpha = 0
            self.DescriptionLabel.alpha = 0
            self.NameShortLabel.alpha = 0
            self.SubjectLabel.alpha = 0
            
        }, completion: nil)
       
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
            self.HiddenDescription.alpha = 1
            self.navigationItem.rightBarButtonItem = nil
            let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
            self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        }, completion: nil)
        
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

extension TaskEditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        touchDescription()
    }
    
    
}
