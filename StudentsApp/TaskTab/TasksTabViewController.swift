//
//  TasksTabViewController.swift
//  StudentsApp
//
//  Created by Admin on 06.10.17.
//  Copyright © 2017 Владислав Саверский. All rights reserved.
//

import UIKit

class TasksTabViewController: UIViewController{
    // MARK: - Variables
    var parametr: String! // переменная для выбота типа сортировки
    var taskOrActivity: String! // переменная для выбора заданий или мереоприятий
    
    var chosenObject: TaskModel?
    
    var ActivitiesAtSubjectArray: [[ActivitiesModel]] = []
    var ActivitiesAtDayArray: [[ActivitiesModel]] = []
    var TasksAtDayArray: [[TaskModel]] = []
    var TasksAtSubjectArray: [[TaskModel]] = []
    var TasksAtPriorityArray: [[TaskModel]] = []
    
    @IBOutlet weak var taskTable: UITableView!
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.backgroundColor = UIColor.clear
        
        taskOrActivity = "task"//выбираем просмотр заданий
        parametr = "time" //выбираем сортировку по времени
        
        let taskCellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        taskTable.register(taskCellNib, forCellReuseIdentifier: "TasksCell")
        
        // Задаем страртове цета кнопок
        subjectButton.tintColor = UIColor.gray
        timeButton.tintColor = UIColor.blue
        priorityButton.tintColor = UIColor.gray
        taskButton.tintColor = UIColor.red
        activityButton.tintColor = UIColor.gray
        
        
        ActivitiesAtSubjectArray = ActivitiesModel.getActivitiesGroupedBySubject()
        ActivitiesAtDayArray = ActivitiesModel.getActivitiesGroupedByDate()
        TasksAtDayArray = TaskModel.getTasksGroupedByDate()
        TasksAtSubjectArray = TaskModel.getTasksGroupedBySubject()
        TasksAtPriorityArray = TaskModel.getTasksGroupedByPriority()
    
        
        // Do any additional setup after loading the view.
    }
        
   
    @IBAction func setTime(_ sender: Any) { //выбор сортировки по дате
        
        parametr = "time"
        subjectButton.tintColor = UIColor.gray
        timeButton.tintColor = UIColor.blue
        if taskOrActivity == "task" {
            priorityButton.tintColor = UIColor.gray
        }
        taskTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        taskTable.scrollToRow(at: index, at: .top, animated: true)
    }
    
    @IBAction func setSubjects(_ sender: Any) { //выбор сортировки по предмету
       
        
        parametr = "subject"
        subjectButton.tintColor = UIColor.blue
        timeButton.tintColor = UIColor.gray
        if taskOrActivity == "task" {
            priorityButton.tintColor = UIColor.gray
        }
        
        taskTable.reloadData()
        
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        taskTable.scrollToRow(at: index, at: .top, animated: true)
        
    }
    
    @IBAction func setPriority(_ sender: Any) { //выбор сортировки по приоритету
        if taskOrActivity == "task" {
        parametr = "priority"
        subjectButton.tintColor = UIColor.gray
        timeButton.tintColor = UIColor.gray
        priorityButton.tintColor = UIColor.blue
        taskTable.reloadData()
            let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
            taskTable.scrollToRow(at: index, at: .top, animated: true)
    }
    }
    
    @IBAction func taskChooseButton(_ sender: Any) { //выбор просмотра заданий
        taskButton.tintColor = UIColor.red
        activityButton.tintColor = UIColor.gray
        priorityButton.tintColor = UIColor.gray
        taskOrActivity = "task"
        taskTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        taskTable.scrollToRow(at: index, at: .top, animated: true)
    }
    
    
    @IBAction func acrivityChooseButton(_ sender: Any) {//выбор просмотра мероприятий
        taskButton.tintColor = UIColor.gray
        activityButton.tintColor = UIColor.red
        
        taskOrActivity = "activity"
     
        if parametr == "priority"  { //так как в мероприятиях нет сортировки по приоритетам - перейдем в сортировку по датам
            setTime((Any).self)
        }
        priorityButton.tintColor = UIColor.white //делаем кнопку невидимой
        taskTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        taskTable.scrollToRow(at: index, at: .top, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromTasksToTasksView"){
            let taskVC = segue.destination as! TaskViewEditViewController
            taskVC.taskModelObject = chosenObject
        }
    }
    
}




extension TasksTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(taskOrActivity == "task"){
            self.hidesBottomBarWhenPushed = true
            switch parametr {
            case "time":
                chosenObject = TasksAtDayArray[indexPath.section][indexPath.row]
                break
            case "subject":
                chosenObject = TasksAtSubjectArray[indexPath.section][indexPath.row]
                break
            case "priority":
                chosenObject = TasksAtPriorityArray[indexPath.section][indexPath.row]
                break
            default:
                chosenObject = TasksAtDayArray[indexPath.section][indexPath.row]
                break
            }
            self.performSegue(withIdentifier: "fromTasksToTasksView", sender: self)
            self.hidesBottomBarWhenPushed = false
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if(taskOrActivity == "task"){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.rounedView?.backgroundColor = UIColor.blue
        }
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if(taskOrActivity == "task"){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.rounedView?.backgroundColor = selectedTaskCell.cellColor
        }
    }
}

extension TasksTabViewController: UITableViewDataSource {
    

    
    func numberOfSections(in tableView: UITableView) -> Int { // Получим количество секций
        if taskOrActivity == "task" { // для вывода заданий
            if parametr == "time" {
            return TasksAtDayArray.count
        }
        
            else { if parametr == "subject" {
                return TasksAtSubjectArray.count
            }
                  else { if parametr == "priority" {
                return (TasksAtPriorityArray.count - 1)
                }
                    else { return 0 }
                }
                
            }
        }
        
        else { //для вывода мероприятий
             if parametr == "time" {
                return ActivitiesAtDayArray.count
            }
                
            else { if parametr == "subject" {
                return ActivitiesAtSubjectArray.count
            }
            else {  return 0  }
            
        }
    }
        
    }
    
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Получим количество строк для конкретной секции
      
      if taskOrActivity == "task" {  // для вывода заданий
        if parametr == "time" {
        return TasksAtDayArray[section].count
        }
       else {
        if parametr == "subject" {
           
            return TasksAtSubjectArray[section].count
        }
        else {
            if parametr == "priority" {
                return TasksAtPriorityArray[section].count
            }
            else {return 0}
        }
        }
        }
     else { //для вывода мероприятий
        if parametr == "time" {
            return ActivitiesAtDayArray[section].count
        }
        else {
            if parametr == "subject" {
                return ActivitiesAtSubjectArray[section].count
            }
            else {return 0}
        }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // Получим заголовок для секции
        
        if taskOrActivity == "task" {  // для вывода заданий
            switch parametr {
            case "time":
            return TasksAtDayArray[section][0].taskDate?.stringFromDate()
            case "subject":
            return TasksAtSubjectArray[section][0].taskSubject
            case "priority":
                switch TasksAtPriorityArray[section][0].taskPriority! {
                case 2:
                    return "Высокий приоритет"
                case 1:
                    return "Средний приоритет"
                case 0:
                    return "Низкий приоритет"
                default:
                    return " "
                }
            default:
            return " "
            
        }
        }
        else { //для вывода мероприятий
            if parametr == "time" {
                return ActivitiesAtDayArray[section][0].activityDate?.stringFromDate()
            }
            else {
                if parametr == "subject" {
                    return ActivitiesAtSubjectArray[section][0].activitySubject
                }
                else {return " "}
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Получим данные для использования в ячейке
         let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath) as! TaskTableViewCell
        
        cell.backgroundColor = UIColor.clear
        
        if taskOrActivity == "task" { // для вывода заданий
        if parametr == "time" { // Вывод данных для сортировки заданий по дате
             cell.initWithTask(model: TasksAtDayArray[indexPath.section][indexPath.row], forSortingType: "Сроки")
            
        }
        
        if parametr == "subject" { // Вывод данных для сортировки заданий по предметам
            cell.initWithTask(model: TasksAtSubjectArray[indexPath.section][indexPath.row], forSortingType: "Предметы")
        }
        
        if parametr == "priority" { // Вывод данных для сортировки заданий по приоритету
            cell.initWithTask(model: TasksAtPriorityArray[indexPath.section][indexPath.row], forSortingType: "Приоритет")
        }
        }
 
        else {
            if parametr == "time" { // Вывод данных для сортировки мероприятий по дате
                cell.initWithActivity(model: ActivitiesAtDayArray[indexPath.section][indexPath.row], forSortingType: "Сроки")
            }
            
            if parametr == "subject" { // Вывод данных для сортировки мероприятий по предметам
                cell.initWithActivity(model: ActivitiesAtSubjectArray[indexPath.section][indexPath.row], forSortingType: "Предметы")
            }
        }
        
        
        return cell
    }
    

}
