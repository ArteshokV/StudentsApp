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
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var subjectTable: UITableView!
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
    var TasksAtSubjectArray: [[TaskModel]] = []
    var filteredSubject: [String] = []
    var searchSubject: [String] = []
    var searchActive : Bool = false
    
    
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
    
        self.view.bringSubview(toFront: DescriptionText)
        DesrY = self.DescriptionText.frame.origin.y
       
        //Ищем предмет
        self.searchBar.isHidden = true
        self.subjectTable.isHidden = true
        
        definesPresentationContext = true
        TasksAtSubjectArray = TaskModel.getTasksGroupedBySubject()
        filteredSubject.append(TasksAtSubjectArray[0][0].taskSubject!)
        var counter = 0
        for task in TasksAtSubjectArray {
            counter = 0
            for subject in filteredSubject {
                if (task[0].taskSubject == subject) {
                    counter+=1
                }
            }
            if counter == 0 {
               filteredSubject.append(task[0].taskSubject!)
                print ("\(task[0].taskSubject!)")
            }
        }
        
        let taskCellNib = UINib(nibName: "TaskTapViewCell", bundle: nil)
        subjectTable.register(taskCellNib, forCellReuseIdentifier: "subject")
        self.subjectTable.reloadData()
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
        
        //subject
        self.searchBar.isHidden = true
        self.subjectTable.isHidden = true
        self.DescriptionText.isHidden = true
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
    
    func touchSubject() {
        searchBar.becomeFirstResponder()
        self.DescriptionText.isHidden = true
        self.navigationItem.hidesBackButton = true
        self.searchBar.isHidden = false
        self.subjectTable.isHidden = false
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
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


extension TaskEditViewController: UISearchBarDelegate {
   
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text != "") {
        searchSubject = filteredSubject.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filteredSubject.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            }}
        else {searchSubject = filteredSubject}
            self.subjectTable.reloadData()
    }
   
    
    
}


extension TaskEditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == DescriptionText {
            touchDescription()
        }
        if textView == SubjectText {
            touchSubject()
        }
    }
    
    
}

extension TaskEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let subText = (tableView.cellForRow(at: indexPath) as! TaskTapViewCell).label.text
        if (subText == "Такого предмета не нашлось, но вы можете создать новый") {
        print("Добавить новый предмет")
        } else {
           self.SubjectText.text = subText
        }
        doneDescriptionEditing()
    }
}

extension TaskEditViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { // Получим количество секций
        return 1
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive && (searchBar.text != "")) {
            if (searchSubject.count == 0) {
                return 1
            }
            else { return searchSubject.count}
        }
        return filteredSubject.count;
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Получим данные для использования в ячейке
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subject", for: indexPath) as! TaskTapViewCell
        if ((searchSubject.count == 0) && searchActive && (searchBar.text != "")) {
          cell.label.text = "Такого предмета не нашлось, но вы можете создать новый"
        } else {
        if(searchActive && (searchBar.text != "")){
            cell.label.text = searchSubject[indexPath.row]
        } else {
            cell.label.text = filteredSubject[indexPath.row];
        }
        if (cell.label.text == ""){
            cell.label.text = "Без названия"
        }
        }
        
        return cell
}

    
    
}
