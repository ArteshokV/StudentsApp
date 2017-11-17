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
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
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
  
    var isChanging = false
    var isDeleted = false
    
    var DesrY: CGFloat!
    
    
    var oldScrolHeight: CGFloat!
    var newScrolHeight: CGFloat!
    var oldScrolWidth: CGFloat!
    var counterD: Int = 0
    var counterDate: Int = 0
    var topYDescr: CGFloat = 0
    
    var TasksAtSubjectArray: [[TaskModel]] = []
    var filteredSubject: [String] = []
    var searchSubject: [String] = []
    var searchActive : Bool = false
    var keyHeight: CGFloat = 0.0
    var counterS: Int = 0
    private var dateFormatterForDate = DateFormatter()
    private var CoorForAnimation:CGFloat = 0
    var pickerDate: Date?
    let appDesign = CustomApplicationLook()
    
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
        
        if (isEditing) {
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
        
        if (isEditing) {
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
        
        if (!isEditing) {
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
    
    @objc func doneDescriptionEditing() {
      self.navigationItem.rightBarButtonItem = nil
        view.endEditing(true)
        
        if (self.searchBar.alpha != 0) {
        self.DescriptionLabel.alpha = 1
        self.SubjectLabel.alpha = 1
        self.SubjectText.alpha = 1
        self.NameShortText.alpha = 1
        self.NameShortLabel.alpha = 1
        self.deleteButton.alpha = 1
        self.DateField.alpha = 1
        self.priorityLabel.alpha = 1
        self.prioritySegment.alpha = 1
        self.searchBar.alpha = 0
        self.subjectTable.alpha = 0
        self.DescriptionText.alpha = 1
        }
        
        self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        self.navigationItem.hidesBackButton = false
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(TaskEditViewController.saveChanges))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
       
        
       
        
    }
    
    func touchDescription() {
     
        self.navigationItem.hidesBackButton = true
        
        self.scrollView.contentInset =  UIEdgeInsetsMake(0.0, 0.0, self.keyHeight, 0.0)
        
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
     
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyHeight = keyboardRectangle.height
           
        }
    }
    
    
    func touchSubject() {
        self.subjectTable.contentInset =  UIEdgeInsetsMake(0.0, 0.0, self.keyHeight, 0.0)
        searchBar.becomeFirstResponder()
        self.DescriptionText.alpha = 0
        self.DescriptionLabel.alpha = 0
        self.SubjectLabel.alpha = 0
        self.SubjectText.alpha = 0
        self.NameShortText.alpha = 0
        self.NameShortLabel.alpha = 0
        self.deleteButton.alpha = 0
        self.DateField.alpha = 0
        self.prioritySegment.alpha = 0
        self.priorityLabel.alpha = 0
        
        self.navigationItem.hidesBackButton = true
        self.searchBar.alpha = 1
        self.subjectTable.alpha = 1
        
        self.view.bringSubview(toFront: searchBar)
        self.view.bringSubview(toFront: subjectTable)
        
        self.navigationItem.rightBarButtonItem = nil
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(TaskEditViewController.doneDescriptionEditing))
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
        //print ("\(string(self.pickerDate))")
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
