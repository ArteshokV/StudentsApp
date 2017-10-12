//
//  taskModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 05.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskModel: NSObject {
    var taskId: Int?
    var taskDate: String?
    var taskNameShort: String?
    var taskSubject: String?
    var taskPriority: Int?
    var taskDescription: String?
    var taskStatus: Int?
    
    static func getTasks() -> Array<TaskModel>{
        //Получаем список заданий
        var returnArray: Array<TaskModel> = Array()
        
        let firstClass: TaskModel = TaskModel()
        firstClass.taskId = 0
        firstClass.taskDate = "15.10.17"
        firstClass.taskNameShort = "ДЗ1"
        firstClass.taskSubject = "Экономика"
        firstClass.taskPriority = 1
        firstClass.taskDescription = "Нужно сдать этот рк"
        firstClass.taskStatus = 0
        let secondClass: TaskModel = TaskModel()
        secondClass.taskId = 1
        secondClass.taskDate = "17.10.17"
        secondClass.taskNameShort = "ДЗ1"
        secondClass.taskSubject = "ТСиСА"
        secondClass.taskPriority = 2
        secondClass.taskDescription = "Нужно сдать этот гр*баный рк"
        secondClass.taskStatus = 0
        let thirdClass: TaskModel = TaskModel()
        thirdClass.taskId = 2
        thirdClass.taskDate = "17.10.17"
        thirdClass.taskNameShort = "ДЗ1"
        thirdClass.taskSubject = "ЭВМ"
        thirdClass.taskPriority = 1
        thirdClass.taskDescription = "Нужно сдать этот гребаный рк"
        thirdClass.taskStatus = 0
        let fourthClass: TaskModel = TaskModel()
        fourthClass.taskId = 3
        fourthClass.taskDate = "14.11.17"
        fourthClass.taskNameShort = "Сдать лабу №1"
        fourthClass.taskSubject = "Программирование"
        fourthClass.taskPriority = 0
        fourthClass.taskDescription = "Нужно сдать этот гребаный рк"
        fourthClass.taskStatus = 0
        let fifthClass: TaskModel = TaskModel()
        fifthClass.taskId = 4
        fifthClass.taskDate = "17.10.17"
        fifthClass.taskNameShort = "ДЗ2"
        fifthClass.taskSubject = "Экономика"
        fifthClass.taskPriority = 2
        fifthClass.taskDescription = "Нужно сдать еще один гребаный рк"
        fifthClass.taskStatus = 0
        let sixthClass: TaskModel = TaskModel()
        sixthClass.taskId = 5
        sixthClass.taskDate = "14.11.17"
        sixthClass.taskNameShort = "ДЗ2"
        sixthClass.taskSubject = "ЭВМ"
        sixthClass.taskPriority = 0
        sixthClass.taskDescription = "Нужно сдать этот гребаный рк"
        sixthClass.taskStatus = 0
        let seventhClass: TaskModel = TaskModel()
        seventhClass.taskId = 6
        seventhClass.taskDate = "14.09.17"
        seventhClass.taskNameShort = "Сдать лаб №1"
        seventhClass.taskSubject = "ЭВМ"
        seventhClass.taskPriority = 1
        seventhClass.taskDescription = "Нужно сдать этот гребаный рк"
        seventhClass.taskStatus = 0
        
        returnArray.append(firstClass)
        returnArray.append(secondClass)
        returnArray.append(thirdClass)
        returnArray.append(fourthClass)
        returnArray.append(fifthClass)
        returnArray.append(sixthClass)
        returnArray.append(seventhClass)
        return returnArray
    }
    
    func addTask() -> Bool {
        //Добавляем задание в БД
        return false
    }
    
    func deleteTask() -> Bool {
        //Удаляем задание из БД
        return false
    }
    
    func updateTask() -> Bool {
        //Обновляем задание в БД
        return false
    }
}
