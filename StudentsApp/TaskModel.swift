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
    var taskDate: Int?
    var taskNameShort: String?
    var taskSubject: String?
    var taskPriority: Int?
    var taskDescription: String?
    var taskStatus: Int?
    
    static func getTasks() -> Array<TaskModel>{
        //Получаем список заданий
        var returnArray: Array<TaskModel> = Array()
        
        let firstClass: TaskModel = TaskModel()
        let secondClass: TaskModel = TaskModel()
        
        returnArray.append(firstClass)
        returnArray.append(secondClass)
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
