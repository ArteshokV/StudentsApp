//
//  TaskEditViewController.swift
//  StudentsApp
//
//  Created by Admin on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskEditViewController: UIViewController {
    
    var taskEditObject: TaskModel? = TaskModel()
    var taskOrActivity = String()
    var isEdit: Bool = false

    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var subjectTable: UITableView!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var NameShortLabel: UILabel!
    @IBOutlet weak var SubjectLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var DescriptionText: UITextView!
    @IBOutlet weak var NameShortText: UITextView!
    @IBOutlet weak var SubjectText: UITextView!
  
    var isDeleted = false
    var isSubjectCanceled = false
    var counterD: Int = 0
    var counterDate: Int = 0
    var filteredSubject: [String] = []
    var subjects: [SubjectModel] = []
    var SubjectsHelpArray: [String] = []
    var searchSubject: [String] = []
    var keyHeight: CGFloat = 0.0
    var counterS: Int = 0
    private var dateFormatterForDate = DateFormatter()
    private var CoorForAnimation:CGFloat = 0
    var pickerDate: Date?
    let appDesign = CustomApplicationLook()
    
    // MARK: - Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = appDesign.tabBarColor
        
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        //customization
        appDesign.initBackground(ofView: self.view)
        DescriptionLabel.textColor = appDesign.mainTextColor
        SubjectLabel.textColor = appDesign.mainTextColor
        NameShortLabel.textColor = appDesign.mainTextColor
        DateField.font = UIFont.boldSystemFont(ofSize: 23)
        priorityLabel.textColor = appDesign.mainTextColor
        prioritySegment.tintColor = appDesign.subTextColor
        
        if (isEdit) {
        DescriptionText.textColor = appDesign.subTextColor
        SubjectText.textColor = appDesign.subTextColor
        NameShortText.textColor = appDesign.subTextColor
        DateField.textColor = appDesign.subTextColor  }
        else {
        DescriptionText.textColor = UIColor.darkGray
        SubjectText.textColor = UIColor.darkGray
        NameShortText.textColor = UIColor.darkGray
        DateField.textColor = UIColor.darkGray
        }
        deleteButton.isHidden = true
        
        if (isEdit) {
            if (SubjectText.text != "")&&(taskEditObject?.taskSubject != "") {
                SubjectText.text = taskEditObject?.taskSubject
            } else {
                SubjectText.text = "Выберите предмет"
                SubjectText.textColor = UIColor.darkGray
            }
            if (NameShortText.text != "")&&(taskEditObject?.taskNameShort != "")  {
                 NameShortText.text = taskEditObject?.taskNameShort
            } else {
                NameShortText.text = "Введите краткое описание задания"
                NameShortText.textColor = UIColor.darkGray
            }
            if (DescriptionText.text != "")&&(taskEditObject?.taskDescription != "")  {
                DescriptionText.text = taskEditObject?.taskDescription
            } else {
                DescriptionText.text = "Введите полное описание задания"
                DescriptionText.textColor = UIColor.darkGray
            }
       
        
        DateField.text = taskEditObject?.taskDate?.stringFromDate()
        prioritySegment.selectedSegmentIndex = (taskEditObject?.taskPriority)!
        deleteButton.isHidden = false
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneDescriptionEditing))
            toolbar.setItems([doneButton], animated: false)
            
            DescriptionText.inputAccessoryView = toolbar
        }
        
        self.subjectTable.alpha = 0
    
        subjects = SubjectModel.getSubjects()
        
        definesPresentationContext = true
        filteredSubject.append(subjects[0].subjectName!)
        var counter = 0
        for sub in subjects {
            counter = 0
            for fSub in filteredSubject {
                if (sub.subjectName == fSub) {
                    counter+=1
                }
            }
            if counter == 0 {
                filteredSubject.append(sub.subjectName!)
                print ("\(sub.subjectName!)")
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
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DescriptionText.setContentOffset(CGPoint.zero, animated: false)
    
    }
    
    // MARK: - subFunctions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyHeight = keyboardRectangle.height
            //print("\(keyHeight)")
        }
    }
    
    func filterToShowSubjects (FilterString: String, ArrayToComplect: Array<String>) -> Array<String> {
            searchSubject = ArrayToComplect.filter({ (text) -> Bool in
                let tmp: NSString = text as NSString
                let range = tmp.range(of: FilterString, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        
        return searchSubject
    }
    
    // MARK: - Save/Delete object
    
    @IBAction func deleteTask(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "Удалить задание", message: "Вы действительно хотите удалить данное задание?", preferredStyle: .alert)
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Нет", style: .default) { action -> Void in
        }
        let deleteAction: UIAlertAction = UIAlertAction(title: "Да", style: .destructive) { action -> Void in
            self.taskEditObject?.delete()
            self.isDeleted = true
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    @objc func saveChanges() {
        
        if (self.DescriptionText.text != "Введите полное описание задания") {
            taskEditObject?.taskDescription = self.DescriptionText.text
        } else {
            taskEditObject?.taskDescription = ""
        }
        
        if (self.SubjectText.text != "Выберите предмет")&&(self.SubjectText.text != "Без названия") {
            taskEditObject?.taskSubject = self.SubjectText.text
        } else {
            taskEditObject?.taskSubject = ""
        }
        
        if (self.NameShortText.text != "Введите краткое описание задания") {
            taskEditObject?.taskNameShort = self.NameShortText.text
        } else {
            taskEditObject?.taskNameShort = ""
        }
        
        
        taskEditObject?.taskPriority = self.prioritySegment.selectedSegmentIndex
        
        if (!isEdit) {
            taskEditObject?.taskStatus = 0
        }
        
        if (taskEditObject?.taskNameShort == "")||(self.DateField.text == "Введите дату") {
        let alertController: UIAlertController = UIAlertController(title: "Ошибка сохранения", message: "Необходимо заполнить поля 'Дата' и 'Описание задания'", preferredStyle: .alert)
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Нет", style: .default) { action -> Void in
        }
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        } else {
        taskEditObject?.taskDate = CustomDateClass(withString: self.DateField.text!)
        taskEditObject?.save()
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - End Editing (done button pressed)
    
    
    @objc func doneDescriptionEditing() {
      self.navigationItem.rightBarButtonItem = nil
        view.endEditing(true)
        
        if (isSubjectCanceled == true) {
            self.SubjectText.textColor = UIColor.darkGray
            self.SubjectText.text = "Выберите предмет"
            isSubjectCanceled = false
        }
        
        self.scrollView.isScrollEnabled = true
        
        if (self.subjectTable.alpha != 0) {
            self.subjectTable.frame.size = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.scrollView.contentOffset = CGPoint.zero
        }, completion: nil)
            
        self.DescriptionLabel.alpha = 1
        self.SubjectLabel.alpha = 1
        self.SubjectText.alpha = 1
        self.NameShortText.alpha = 1
        self.NameShortLabel.alpha = 1
        self.deleteButton.alpha = 1
        self.DateField.alpha = 1
        self.priorityLabel.alpha = 1
        self.prioritySegment.alpha = 1
        self.subjectTable.alpha = 0
        self.DescriptionText.alpha = 1
        }
       
            self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
       
        
        self.navigationItem.hidesBackButton = false
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
       
        
       
        
    }
   
    // MARK: - Touches
    
    func touchDescription() {
     
        self.navigationItem.hidesBackButton = true
        
        self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, self.keyHeight, 0.0)
        
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
     
    }
    
  
    
    
    func touchSubject() {
        isSubjectCanceled = true
       self.subjectTable.frame.size = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height)
       
            self.scrollView.isScrollEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: self.SubjectLabel.frame.origin.y)
        }, completion: { _ in
            print("\(self.keyHeight)")
            self.subjectTable.frame.size = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height - self.NameShortLabel.frame.origin.y + self.SubjectLabel.frame.origin.y  - self.keyHeight)
            self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, self.keyHeight, 0.0)
        })
        self.navigationItem.hidesBackButton = true
        self.DescriptionText.alpha = 0
        self.DescriptionLabel.alpha = 0
        self.NameShortText.alpha = 0
        self.NameShortLabel.alpha = 0
        self.deleteButton.alpha = 0
        self.DateField.alpha = 0
        self.prioritySegment.alpha = 0
        self.priorityLabel.alpha = 0
        self.subjectTable.alpha = 1
        
       
        self.view.bringSubview(toFront: subjectTable)
        
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
    }
    
    func touchName() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, self.keyHeight, 0.0)
    }
    
    
    func touchDate() {
      
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        let datePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 0, width: 0, height: 0))
        customView.addSubview(datePicker)
        datePicker.datePickerMode = UIDatePickerMode.date
        DateField.inputView = customView
    
        if (DateField.text != "Введите дату") {
            datePicker.setDate((taskEditObject?.taskDate?.currentDate)!, animated: false)
     
        }
        
        datePicker.addTarget(self, action: #selector(TaskEditViewController.ChangeTaskDate), for: UIControlEvents.valueChanged)
      
        self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, customView.frame.height, 0.0)
        
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        
    }
  
    
    @objc func ChangeTaskDate (sender:UIDatePicker) {
        DateField.text = dateFormatterForDate.string(from: sender.date)
        self.pickerDate = sender.date
        taskEditObject?.taskDate = CustomDateClass(withString: self.DateField.text!)
        DateField.textColor = appDesign.subTextColor
        
    }
   

}

// MARK: - Delegates

extension TaskEditViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if (self.SubjectText.text != "") {
            self.SubjectsHelpArray = self.filterToShowSubjects(FilterString: SubjectText.text, ArrayToComplect: self.filteredSubject)
            self.subjectTable.reloadData()
        }
        else
        {
            self.SubjectsHelpArray = self.filteredSubject
            self.subjectTable.reloadData()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == DescriptionText {
            if (self.DescriptionText.textColor == UIColor.darkGray) {
                self.DescriptionText.text = ""
                self.DescriptionText.textColor = self.appDesign.subTextColor
            }
            touchDescription()
            
        }
        if textView == SubjectText {
            if (self.SubjectText.textColor == UIColor.darkGray) {
                self.SubjectText.text = ""
                self.SubjectText.textColor = self.appDesign.subTextColor
            }
            self.SubjectsHelpArray = filteredSubject
            self.subjectTable.reloadData()
            touchSubject()
            
        }
        if textView == NameShortText {
            if (self.NameShortText.textColor == UIColor.darkGray) {
                self.NameShortText.text = ""
                self.NameShortText.textColor = self.appDesign.subTextColor
            }
            touchName()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.doneDescriptionEditing()
            return true
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == DescriptionText {
            if (self.DescriptionText.text == "") {
                self.DescriptionText.textColor = UIColor.darkGray
                self.DescriptionText.text = "Введите полное описание задания"
            }
            else {
               self.DescriptionText.textColor = self.appDesign.subTextColor
            }
            
        }
        if textView == SubjectText {
            if (self.SubjectText.text == "") {
                self.SubjectText.textColor = UIColor.darkGray
                self.SubjectText.text = "Выберите предмет"
            }
            else {
                self.SubjectText.textColor = self.appDesign.subTextColor
            }
        }
        if textView == NameShortText {
            if (self.NameShortText.text == "") {
                self.NameShortText.textColor = UIColor.darkGray
                self.NameShortText.text = "Введите краткое описание задания"
            }
            else {
                self.NameShortText.textColor = self.appDesign.subTextColor
            }
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

// MARK: - SearchTable

extension TaskEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let subText = (tableView.cellForRow(at: indexPath) as! TaskTapViewCell).label.text
        if (subText == "Такого предмета не нашлось, но вы можете создать новый") {
        print("Добавить новый предмет")
        } else {
           self.SubjectText.text = subText
            self.SubjectText.textColor = appDesign.subTextColor
        }
        isSubjectCanceled = false
         doneDescriptionEditing()
    }
}

extension TaskEditViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { // Получим количество секций
        return 1
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubjectsHelpArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Получим данные для использования в ячейке
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subject", for: indexPath) as! TaskTapViewCell
        //if ((searchSubject.count == 0) && searchActive && (searchBar.text != "")) {
        if (SubjectsHelpArray.count == 0) {
          cell.label.text = "Такого предмета не нашлось, но вы можете создать новый"
        } else {
     
           cell.label.text = SubjectsHelpArray[indexPath.row]
            if (cell.label.text == ""){
                cell.label.text = "Без названия"
            }
        }
        
        return cell
}

    
    
}
