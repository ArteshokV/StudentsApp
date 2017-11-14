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
    
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityField: UITextField!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBOutlet weak var NameShortText: UITextView!
    
    @IBOutlet weak var SubjectText: UITextView!
  
    var DesrY: CGFloat!
    var TasksAtSubjectArray: [[TaskModel]] = []
    var filteredSubject: [String] = []
    var searchSubject: [String] = []
    var searchActive : Bool = false
    var keyHeight: CGFloat = 0
    var counterS: Int = 0
    private var dateFormatterForDate = DateFormatter()
    private var CoorForAnimation:CGFloat = 0
    
    let appDesign = CustomApplicationLook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        //customization
        appDesign.initBackground(ofView: self.view)
        DescriptionLabel.textColor = appDesign.subTextColor
        SubjectLabel.textColor = appDesign.subTextColor
        NameShortLabel.textColor = appDesign.subTextColor
        DescriptionText.textColor = appDesign.mainTextColor
        SubjectText.textColor = appDesign.mainTextColor
        NameShortText.textColor = appDesign.mainTextColor
        dateLabel.textColor = appDesign.subTextColor
        DateField.textColor = appDesign.mainTextColor
        priorityLabel.textColor = appDesign.subTextColor
        priorityField.textColor = appDesign.mainTextColor
        
        // Do any additional setup after loading the view.
        SubjectText.text = taskEditObject?.taskSubject
        SubjectText.font = UIFont.boldSystemFont(ofSize: 18)
        NameShortText.text = taskEditObject?.taskNameShort
        DescriptionText.text = taskEditObject?.taskDescription
        DateField.text = taskEditObject?.taskDate?.stringFromDate()
        //priorityField.text = taskEditObject?.taskPriority
        switch taskEditObject?.taskPriority {
        case 0?:
            priorityField.text = "Низкий"
            break
        case 1?:
            priorityField.text = "Средний"
            break
        case 2?:
            priorityField.text = "Высокий"
            break
        default:
            priorityField.text = "Не установлен"
            break
        }
        
        
        self.view.bringSubview(toFront: DescriptionText)
        DesrY = self.DescriptionText.frame.origin.y
       
        //Ищем предмет
        self.searchBar.alpha = 0
        self.subjectTable.alpha = 0
        
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
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        dateFormatterForDate.dateFormat = "dd.MM.yyyy"
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
        taskEditObject?.taskSubject = self.SubjectText.text
        taskEditObject?.taskNameShort = self.NameShortText.text
        taskEditObject?.save()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func doneDescriptionEditing() {
      self.navigationItem.rightBarButtonItem = nil
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.DescriptionText.frame.origin.y = self.DesrY
            var oldFrame = self.DescriptionText.frame
            let h = self.stackView.frame.origin.y - self.DesrY - 8
            oldFrame.size = CGSize(width: self.DescriptionText.frame.width, height: h)
            self.DescriptionText.frame = oldFrame
            
        }, completion: nil )
        
        if (self.searchBar.alpha == 0) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
           self.SubjectLabel.alpha = 1
        }, completion: nil )
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseInOut, animations: {
            self.SubjectText.alpha = 1
        }, completion: nil )
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: {
            self.DescriptionLabel.alpha = 1
        }, completion: nil )
        UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveEaseInOut, animations: {
            self.NameShortText.alpha = 1
        }, completion: nil )
        UIView.animate(withDuration: 0.1, delay: 0.4, options: .curveEaseInOut, animations: {
            self.NameShortLabel.alpha = 1
        }, completion: nil )
        } else {
        self.DescriptionLabel.alpha = 1
        self.SubjectLabel.alpha = 1
        self.SubjectText.alpha = 1
        self.NameShortText.alpha = 1
        self.NameShortLabel.alpha = 1 }
        self.dateLabel.alpha = 1
        self.DateField.alpha = 1
        self.priorityField.alpha = 1
        self.priorityLabel.alpha = 1
        
        //self.view.bringSubview(toFront: self.bottomView)
        
        //subject
        self.searchBar.alpha = 0
        self.subjectTable.alpha = 0
        
        self.DescriptionText.alpha = 1
        
        self.navigationItem.hidesBackButton = false
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        self.DescriptionText.setContentOffset(CGPoint.zero, animated: false)
        
        
    }
    
    func touchDescription() {
       
        self.navigationItem.hidesBackButton = true
        if (self.searchBar.alpha == 0) {
            UIView.animate(withDuration: 0.1, delay: 0.4, options: .curveEaseInOut, animations: {
                self.SubjectLabel.alpha = 0
            }, completion: nil )
            UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveEaseInOut, animations: {
                self.SubjectText.alpha = 0
            }, completion: nil )
            UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: {
                self.DescriptionLabel.alpha = 0
            }, completion: nil )
            UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseInOut, animations: {
                self.NameShortText.alpha = 0
            }, completion: nil )
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.NameShortLabel.alpha = 0
            }, completion: nil )
        } else {
            self.DescriptionLabel.alpha = 0
            self.SubjectLabel.alpha = 0
            self.SubjectText.alpha = 0
            self.NameShortText.alpha = 0
            self.NameShortLabel.alpha = 0 }
        self.dateLabel.alpha = 0
        self.DateField.alpha = 0
        self.priorityField.alpha = 0
        self.priorityLabel.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
            self.DescriptionText.frame.origin.y = 18 + (self.navigationController?.navigationBar.frame.height)!
            
            var newFrame = self.DescriptionText.frame
            newFrame.size = CGSize(width: self.DescriptionText.frame.width, height: self.view.frame.height - (18 + (self.navigationController?.navigationBar.frame.height)!) - self.keyHeight)
            self.DescriptionText.frame = newFrame
            
            self.navigationItem.rightBarButtonItem = nil
            let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
            self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        }, completion: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyHeight = keyboardRectangle.height
           // print("\(self.keyHeight)")
        }
    }
    
    
    func touchSubject() {
        searchBar.becomeFirstResponder()
        self.DescriptionText.alpha = 0
        self.DescriptionLabel.alpha = 0
        self.SubjectLabel.alpha = 0
        self.SubjectText.alpha = 0
        self.NameShortText.alpha = 0
        self.NameShortLabel.alpha = 0
        self.dateLabel.alpha = 0
        self.DateField.alpha = 0
        self.priorityField.alpha = 0
        self.priorityLabel.alpha = 0
        
        self.navigationItem.hidesBackButton = true
        self.searchBar.alpha = 1
        self.subjectTable.alpha = 1
        
        
        if (counterS == 0) {
        var newFrameForSubjectTable = self.subjectTable.frame
        newFrameForSubjectTable.size = CGSize(width: self.subjectTable.frame.width, height: self.subjectTable.frame.height - self.keyHeight + 30)
        self.subjectTable.frame = newFrameForSubjectTable
        }
        counterS+=1
         
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
    }
    
    func touchDate() {
       print("fghfdjfjd")
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        let doneButton:UIButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2 - 50), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        doneButton.addTarget(self, action: #selector(TaskEditViewController.pickerDoneButtonPressed), for: UIControlEvents.touchUpInside)
        let datePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 40, width: 0, height: 0))
        customView.addSubview(datePicker)
        customView.addSubview(doneButton)
        datePicker.datePickerMode = UIDatePickerMode.date
        DateField.inputView = customView
        //PeriodicStartDate.tintColor = UIColor.clear
        //datePicker.minimumDate = EditClassController.DateOfBeginOfSemester.currentDate
        if (DateField.text != "") {
            datePicker.setDate((taskEditObject?.taskDate?.currentDate)!, animated: false)
        }
        
        datePicker.addTarget(self, action: #selector(TaskEditViewController.ChangeTaskDate), for: UIControlEvents.valueChanged)
        self.stackView.layer.backgroundColor = UIColor.darkGray.cgColor
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.CoorForAnimation = customView.frame.height - (self.view.frame.height - self.stackView.center.y - self.stackView.frame.height/2)
                self.stackView.center.y -= self.CoorForAnimation
                
            }, completion: nil)
        
    }
    
    @objc func pickerDoneButtonPressed (sender:UIButton) {
        view.endEditing(true)
        
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.stackView.center.y += self.CoorForAnimation
                self.CoorForAnimation = 0
                
            }, completion: nil)
        
    }
    
    
    @objc func ChangeTaskDate (sender:UIDatePicker) {
        DateField.text = dateFormatterForDate.string(from: sender.date)
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

extension TaskEditViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == DateField {
            touchDate()
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
