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
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var NameShortLabel: UILabel!
    @IBOutlet weak var SubjectLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var HiddenDescription: UITextView!
    @IBOutlet weak var PriorityButton: UIButton!
    @IBOutlet weak var DateButton: UIButton!
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBOutlet weak var NameShortText: UITextView!
    
    @IBOutlet weak var SubjectText: UITextView!
  
    var DesrY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        
        // Do any additional setup after loading the view.
        SubjectText.text = taskEditObject?.taskSubject
        SubjectText.font = UIFont.boldSystemFont(ofSize: 18)
        NameShortText.text = taskEditObject?.taskNameShort
        DescriptionText.text = taskEditObject?.taskDescription
        DescriptionText.backgroundColor = UIColor.white
        DescriptionText.layer.backgroundColor = UIColor.white.cgColor
        DateButton.setTitle(taskEditObject?.taskDate?.stringFromDate(), for: .normal)
        PriorityButton.setTitle(taskEditObject?.taskPriority?.description, for: .normal)
     //DescriptionText.setContentOffset(CGPoint.zero, animated: false)
        self.view.bringSubview(toFront: DescriptionText)
        DesrY = self.DescriptionText.frame.origin.y
       
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
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
            self.DescriptionText.frame.origin.y = self.DesrY
          
            var oldFrame = self.DescriptionText.frame
            let h = self.stackView.frame.origin.y - self.DesrY - 8
            oldFrame.size = CGSize(width: self.DescriptionText.frame.width, height: h)
            self.DescriptionText.frame = oldFrame
            
        }, completion: nil )
        
        self.view.bringSubview(toFront: self.bottomView)
        self.navigationItem.hidesBackButton = false
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        self.DescriptionText.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func touchDescription() {
       
        self.navigationItem.hidesBackButton = true
      
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
            self.DescriptionText.frame.origin.y = 18 + (self.navigationController?.navigationBar.frame.height)!
            
            var newFrame = self.DescriptionText.frame
            newFrame.size = CGSize(width: self.DescriptionText.frame.width, height: self.view.frame.height - (18 + (self.navigationController?.navigationBar.frame.height)!) - 250)
            self.DescriptionText.frame = newFrame
            
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
