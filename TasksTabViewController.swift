//
//  TasksTabViewController.swift
//  StudentsApp
//
//  Created by Admin on 06.10.17.
//  Copyright © 2017 Владислав Саверский. All rights reserved.
//

import UIKit

class TasksTabViewController: UIViewController{
    
    var parametr: String! // переменная для выбота типа сортировки
    var taskOrActivity: String! // переменная для выбора заданий или мереоприятий
    
    
    
    struct tasksAtDay {  //Вспомогательная структура для сортировки заданий по дням
        var sectionName : String!
        var sectionObjects : Array<TaskModel> = Array()      //(структура число - task
    }
    
    var tasksAtDayArray = Array<tasksAtDay>() // Источник данных (tasks рассортированные по числам)
    
    
    
    struct tasksAtSubject {  //Вспомогательная структура для сортировки заданий  по предметам
        var sectionName : String!
        var sectionObjects : Array<TaskModel> = Array()      //(структура предмет - task
    }
    
    var tasksAtSubjectArray = Array<tasksAtSubject>() // Источник данных (tasks рассортированные по предметам)
    
    
    
    struct tasksAtPriority {  //Вспомогательная структура для сортировки заданий по предметам
        var sectionName : Int!
        var sectionObjects : Array<TaskModel> = Array()      //(структура приоритет - task
    }
    
    var tasksAtPriorityArray = Array<tasksAtPriority>() // Источник данных (tasks рассортированные по приоритету)
    
    
    struct activitiesAtDay {  //Вспомогательная структура для сортировки мероприятий по дням
        var sectionName : String!
        var sectionObjects : Array<ActivitiesModel> = Array()      //(структура число - activities
    }
    
    var activitiesAtDayArray = Array<activitiesAtDay>() // Источник данных (activities рассортированные по числам)
    
    
    
    struct activitiesAtSubject {  //Вспомогательная структура для сортировки мероприятий по предметам
        var sectionName : String!
        var sectionObjects : Array<ActivitiesModel> = Array()      //(структура предмет - activities
    }
    
    var activitiesAtSubjectArray = Array<activitiesAtSubject>() // Источник данных (activities рассортированные по предметам)
    
    
    
    @IBOutlet weak var taskTable: UITableView!
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    
    var TodayDate = Date()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskOrActivity = "task"//выбираем просмотр заданий
        parametr = "time" //выбираем сортировку по времени
        
        
        // Задаем страртове цета кнопок
        subjectButton.tintColor = UIColor.gray
        timeButton.tintColor = UIColor.blue
        priorityButton.tintColor = UIColor.gray
        taskButton.tintColor = UIColor.red
        activityButton.tintColor = UIColor.gray
        
        taskTable.estimatedRowHeight = 85 // пытаемся выставить высоту ячейки
        //taskTable.rowHeight = UITableViewAutomaticDimension
        
        var taskArray: Array<TaskModel> = TaskModel.getTasks() // получение данных из модели заданий
        var activitiesArray: Array<ActivitiesModel> = ActivitiesModel.getActivities() // получение данных из модели контрольных мероприятий
        
        //реализация сортировки заданий по дате
        var ttt: Array<TaskModel> = Array()
        
        var tasksAtDayZero: Array<TaskModel> = Array()
        tasksAtDayZero.append(taskArray[0])
        
        tasksAtDayArray.append(tasksAtDay(sectionName: taskArray[0].taskDate, sectionObjects: tasksAtDayZero))
        
        var count: Int!
        
        
        for i in 1...(taskArray.count - 1) {
            count = 0
            for j in 0...(tasksAtDayArray.count - 1) {
                if (taskArray[i].taskDate == tasksAtDayArray[j].sectionName) {
                    tasksAtDayArray[j].sectionObjects.append(taskArray[i])
                }
                else { count = count + 1 }
                
                if count == tasksAtDayArray.count {
                    ttt.append(taskArray[i])
                    tasksAtDayArray.append(tasksAtDay(sectionName: taskArray[i].taskDate, sectionObjects: ttt))
                    ttt.removeAll()
                }
            }
        }
        
        
        
        
        //реализация сортировки заданий по Предметам
        var sss: Array<TaskModel> = Array()
        
        var tasksAtSubjectZero: Array<TaskModel> = Array()
        tasksAtSubjectZero.append(taskArray[0])
        
        tasksAtSubjectArray.append(tasksAtSubject(sectionName: taskArray[0].taskSubject, sectionObjects: tasksAtSubjectZero))
        
       
        
        
        for i in 1...(taskArray.count - 1) {
            count = 0
            for j in 0...(tasksAtSubjectArray.count - 1) {
                if (taskArray[i].taskSubject == tasksAtSubjectArray[j].sectionName) {
                    tasksAtSubjectArray[j].sectionObjects.append(taskArray[i])
                }
                else { count = count + 1 }
                
                if count == tasksAtSubjectArray.count {
                    sss.append(taskArray[i])
                    tasksAtSubjectArray.append(tasksAtSubject(sectionName: taskArray[i].taskSubject, sectionObjects: sss))
                    sss.removeAll()
                }
            }
        }
        
    //Реализация сортировки заданий по приоритету
        var ppp: Array<TaskModel> = Array()
        
        var tasksAtPriorityZero: Array<TaskModel> = Array()
        
        tasksAtPriorityArray.append(tasksAtPriority(sectionName: 2, sectionObjects: tasksAtPriorityZero))
        tasksAtPriorityArray.append(tasksAtPriority(sectionName: 1, sectionObjects: tasksAtPriorityZero))
        tasksAtPriorityArray.append(tasksAtPriority(sectionName: 0, sectionObjects: tasksAtPriorityZero))
        
        for i in 0...(taskArray.count - 1) {
            count = 0
            for j in 0...(tasksAtPriorityArray.count - 1) {
                if (taskArray[i].taskPriority == tasksAtPriorityArray[j].sectionName) {
                    tasksAtPriorityArray[j].sectionObjects.append(taskArray[i])
                }
                else { count = count + 1 }
                
                if count == tasksAtPriorityArray.count {
                    ppp.append(taskArray[i])
                    tasksAtPriorityArray.append(tasksAtPriority(sectionName: taskArray[i].taskPriority, sectionObjects: ppp))
                    ppp.removeAll()
                }
            }
        }
        
        //реализация сортировки мероприятий по дате
        var tta: Array<ActivitiesModel> = Array()
        
        var activitiesAtDayZero: Array<ActivitiesModel> = Array()
        activitiesAtDayZero.append(activitiesArray[0])
        
        activitiesAtDayArray.append(activitiesAtDay(sectionName: activitiesArray[0].activityDate, sectionObjects: activitiesAtDayZero))
        
        
        for i in 1...(activitiesArray.count - 1) {
            count = 0
            for j in 0...(activitiesAtDayArray.count - 1) {
                if (activitiesArray[i].activityDate == activitiesAtDayArray[j].sectionName) {
                    activitiesAtDayArray[j].sectionObjects.append(activitiesArray[i])
                }
                else { count = count + 1 }
                
                if count == activitiesAtDayArray.count {
                    tta.append(activitiesArray[i])
                    activitiesAtDayArray.append(activitiesAtDay(sectionName: activitiesArray[i].activityDate, sectionObjects: tta))
                    tta.removeAll()
                }
            }
        }
        
        
        
        
        //реализация сортировки мероприятий по Предметам
        var ssa: Array<ActivitiesModel> = Array()
        
        var activitiesAtSubjectZero: Array<ActivitiesModel> = Array()
        activitiesAtSubjectZero.append(activitiesArray[0])
        
        activitiesAtSubjectArray.append(activitiesAtSubject(sectionName: activitiesArray[0].activitySubject, sectionObjects: activitiesAtSubjectZero))
        
        
        
        
        for i in 1...(activitiesArray.count - 1) {
            count = 0
            for j in 0...(activitiesAtSubjectArray.count - 1) {
                if (activitiesArray[i].activitySubject == activitiesAtSubjectArray[j].sectionName) {
                    activitiesAtSubjectArray[j].sectionObjects.append(activitiesArray[i])
                }
                else { count = count + 1 }
                
                if count == activitiesAtSubjectArray.count {
                    ssa.append(activitiesArray[i])
                    activitiesAtSubjectArray.append(activitiesAtSubject(sectionName: activitiesArray[i].activitySubject, sectionObjects: ssa))
                    ssa.removeAll()
                }
            }
        }
        
        //Реализация сортировки по приоритету
        // Do any additional setup after loading the view.
    }
        
   
    @IBAction func setTime(_ sender: Any) { //сортировка по дате
        
        parametr = "time"
        subjectButton.tintColor = UIColor.gray
        timeButton.tintColor = UIColor.blue
        priorityButton.tintColor = UIColor.gray
        taskTable.reloadData()
        
    }
    
    @IBAction func setSubjects(_ sender: Any) { // сортировка по предмету
       
        
        parametr = "subject"
        subjectButton.tintColor = UIColor.blue
        timeButton.tintColor = UIColor.gray
        priorityButton.tintColor = UIColor.gray
        taskTable.reloadData()
    }
    
    @IBAction func setPriority(_ sender: Any) { // сортировка по приоритету
        if taskOrActivity == "task" {
        parametr = "priority"
        subjectButton.tintColor = UIColor.gray
        timeButton.tintColor = UIColor.gray
        priorityButton.tintColor = UIColor.blue
        taskTable.reloadData()
    }
    }
    
    @IBAction func taskChooseButton(_ sender: Any) {
        taskButton.tintColor = UIColor.red
        activityButton.tintColor = UIColor.gray
        priorityButton.tintColor = UIColor.gray
        taskOrActivity = "task"
        //parametr = "time"
        taskTable.reloadData()
    }
    
    
    @IBAction func acrivityChooseButton(_ sender: Any) {
        taskButton.tintColor = UIColor.gray
        activityButton.tintColor = UIColor.red
        
        taskOrActivity = "activity"
        
        
        //priorityButton.isEnabled = false
        
        
        if parametr == "priority"  {
            setTime((Any).self)
        }
        priorityButton.tintColor = UIColor.white
        taskTable.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}




extension TasksTabViewController: UITableViewDelegate {
    
}

extension TasksTabViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int { // Получим количество секций
        if taskOrActivity == "task" {
            if parametr == "time" {
            return tasksAtDayArray.count
        }
        
            else { if parametr == "subject" {
            return tasksAtSubjectArray.count
        }
                  else { if parametr == "priority" {
            return tasksAtPriorityArray.count
        }
        else { return 0 }
                
                }
                
            }
        }
        
        else {
             if parametr == "time" {
                return activitiesAtDayArray.count
            }
                
            else { if parametr == "subject" {
                return activitiesAtSubjectArray.count
            }
            else {  return 0  }
            
        }
    }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Получим количество строк для конкретной секции
     if taskOrActivity == "task" {
        if parametr == "time" {
        return tasksAtDayArray[section].sectionObjects.count
        }
       else {
        if parametr == "subject" {
            return tasksAtSubjectArray[section].sectionObjects.count
        }
        else {
            if parametr == "priority" {
                return tasksAtPriorityArray[section].sectionObjects.count
            }
            else {return 0}
        }
        }
        }
     else {
        if parametr == "time" {
            return activitiesAtDayArray[section].sectionObjects.count
        }
        else {
            if parametr == "subject" {
                return activitiesAtSubjectArray[section].sectionObjects.count
            }
            else {return 0}
        }
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // Получим заголовок для секции
        
        if taskOrActivity == "task" {
        if parametr == "time" {
            return tasksAtDayArray[section].sectionName
        }
        else {
            if parametr == "subject" {
                return tasksAtSubjectArray[section].sectionName
            }
            else {
                if parametr == "priority" {
                    if tasksAtPriorityArray[section].sectionName == 2 {
                        return "Высокий приоритет"
                    }
                    else {
                        if tasksAtPriorityArray[section].sectionName == 1 {
                            return "Средний приоритет"
                        }
                        else {return "Низкий приоритет"
                        } }
                }
                else {return " "}
            }
            } }
        else {
            if parametr == "time" {
                return activitiesAtDayArray[section].sectionName
            }
            else {
                if parametr == "subject" {
                    return activitiesAtSubjectArray[section].sectionName
                }
                else {return " "}
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Получим данные для использования в ячейке
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! taskTableViewCell
        
        if taskOrActivity == "task" {
        if parametr == "time" { // Вывод данных для сортировки по дате
        cell.dateLabel.text = tasksAtDayArray[indexPath.section].sectionObjects[indexPath.row].taskSubject
        cell.subjectLabel.text = ""
        cell.shortNameLabel.text = tasksAtDayArray[indexPath.section].sectionObjects[indexPath.row].taskNameShort
        }
        
        if parametr == "subject" { // Вывод данных для сортировки по предметам
            cell.dateLabel.text = tasksAtSubjectArray[indexPath.section].sectionObjects[indexPath.row].taskDate
            cell.subjectLabel.text = ""
            cell.shortNameLabel.text = tasksAtSubjectArray[indexPath.section].sectionObjects[indexPath.row].taskNameShort
        }
        
        if parametr == "priority" { // Вывод данных для сортировки по приоритету
            cell.dateLabel.text = tasksAtPriorityArray[indexPath.section].sectionObjects[indexPath.row].taskDate
            cell.subjectLabel.text = tasksAtPriorityArray[indexPath.section].sectionObjects[indexPath.row].taskSubject
            cell.shortNameLabel.text = tasksAtPriorityArray[indexPath.section].sectionObjects[indexPath.row].taskNameShort
        }
        }
        else {
            if parametr == "time" { // Вывод данных для сортировки по дате
                cell.dateLabel.text = activitiesAtDayArray[indexPath.section].sectionObjects[indexPath.row].activitySubject
                cell.subjectLabel.text = ""
                cell.shortNameLabel.text = activitiesAtDayArray[indexPath.section].sectionObjects[indexPath.row].activityNameShort
            }
            
            if parametr == "subject" { // Вывод данных для сортировки по предметам
                cell.dateLabel.text = activitiesAtSubjectArray[indexPath.section].sectionObjects[indexPath.row].activityDate
                cell.subjectLabel.text = ""
                cell.shortNameLabel.text = activitiesAtSubjectArray[indexPath.section].sectionObjects[indexPath.row].activityNameShort
            }
        }
        
        return cell
    }
    
    
    
}
