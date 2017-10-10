//
//  TasksTabViewController.swift
//  StudentsApp
//
//  Created by Admin on 06.10.17.
//  Copyright © 2017 Владислав Саверский. All rights reserved.
//

import UIKit

class TasksTabViewController: UIViewController{
    
    var parametr: String!
    
    struct tasksAtDay {  //Вспомогательная структура для сортировки по дням
        var sectionName : String!
        var sectionObjects : Array<TaskModel> = Array()      //(структура число - task
    }
    
    var tasksAtDayArray = Array<tasksAtDay>() // Источник данных (tasks рассортированные по числам)
    
    
    
    struct tasksAtSubject {  //Вспомогательная структура для сортировки по предметам
        var sectionName : String!
        var sectionObjects : Array<TaskModel> = Array()      //(структура предмет - task
    }
    
    var tasksAtSubjectArray = Array<tasksAtSubject>() // Источник данных (tasks рассортированные по числам)
    
    
    
    struct tasksAtPriority {  //Вспомогательная структура для сортировки по предметам
        var sectionName : Int!
        var sectionObjects : Array<TaskModel> = Array()      //(структура предмет - task
    }
    
    var tasksAtPriorityArray = Array<tasksAtPriority>() // Источник данных (tasks рассортированные по числам)
    
    
    
    @IBOutlet weak var taskTable: UITableView!
    
    @IBOutlet weak var heightButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.estimatedRowHeight = 85
        //taskTable.rowHeight = UITableViewAutomaticDimension
        
        var taskArray: Array<TaskModel> = TaskModel.getTasks() // получение данных из модели
        
        
        //реализация сортировки по дате
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
        
        
        parametr = "time"
        
        //реализация сортировки по Предметам
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
        
    //Реализация сортировки по приоритету
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
        
        // Do any additional setup after loading the view.
    }
        
   
    @IBAction func setTime(_ sender: Any) { //сортировка по дате
        
       parametr = "time"
        taskTable.reloadData()
        
    }
    
    @IBAction func setSubjects(_ sender: Any) { // сортировка по предмету
       
        
        parametr = "subject"
        taskTable.reloadData()
    }
    
    @IBAction func setPriority(_ sender: Any) { // сортировка по приоритету
        parametr = "priority"
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
    func numberOfSections(in tableView: UITableView) -> Int {
        if parametr == "time" {
            return tasksAtDayArray.count
        }
        
        else { if parametr == "subject" {
            return tasksAtSubjectArray.count
        }
        else { if parametr == "priority" {
            return tasksAtPriorityArray.count
        }
        else { return 0 } } }
    }
    
    // Получим количество строк для конкретной секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    // Получим заголовок для секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if parametr == "time" {
            return tasksAtDayArray[section].sectionName
        }
        else {
            if parametr == "subject" {
                return tasksAtSubjectArray[section].sectionName
            }
            else {
                if parametr == "priority" {
                    return String(tasksAtPriorityArray[section].sectionName)
                }
                else {return " "}
            }
        }
    }
    
    // Получим данные для использования в ячейке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! taskTableViewCell
        
        if parametr == "time" {
        cell.dateLabel.text = tasksAtDayArray[indexPath.section].sectionObjects[indexPath.row].taskSubject
        cell.subjectLabel.text = ""
        cell.shortNameLabel.text = tasksAtDayArray[indexPath.section].sectionObjects[indexPath.row].taskNameShort
        }
        
        if parametr == "subject" {
            cell.dateLabel.text = tasksAtSubjectArray[indexPath.section].sectionObjects[indexPath.row].taskDate
            cell.subjectLabel.text = ""
            cell.shortNameLabel.text = tasksAtSubjectArray[indexPath.section].sectionObjects[indexPath.row].taskNameShort
        }
        
        if parametr == "priority" {
            cell.dateLabel.text = tasksAtPriorityArray[indexPath.section].sectionObjects[indexPath.row].taskDate
            cell.subjectLabel.text = tasksAtPriorityArray[indexPath.section].sectionObjects[indexPath.row].taskSubject
            cell.shortNameLabel.text = tasksAtPriorityArray[indexPath.section].sectionObjects[indexPath.row].taskNameShort
        }
        
        return cell
    }
    
    
    
}
