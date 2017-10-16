//
//  taskModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 05.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class TaskModel: NSObject {
    var TasksDatabaseObject: Tasks?
    var taskDate: CustomDateClass?
    var taskNameShort: String?
    var taskSubject: String?
    var taskPriority: Int?
    var taskDescription: String?
    var taskStatus: Int?
    
    static func getTasks() -> Array<TaskModel>{
        //Получаем список заданий
        var returnArray: Array<TaskModel> = Array()
        
        let fetchRequest:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            for result in searchResults as [Tasks]{
                returnArray.append(TaskModel(withDatabaseObject: result))
            }
        }
        catch{
            print("Error: \(error)")
        }

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
    
    override init() {
        super.init()
    }
    
    init(withDatabaseObject: Tasks) {
        super.init()
        
        self.TasksDatabaseObject = withDatabaseObject
        self.taskDate = CustomDateClass(withString: "15.10.17")
        self.taskNameShort = TasksDatabaseObject?.shortName
        self.taskPriority = Int(TasksDatabaseObject!.priority)
        self.taskDescription = TasksDatabaseObject?.descrp
        self.taskStatus = Int(TasksDatabaseObject!.status)
        
        if(TasksDatabaseObject?.subject != nil){
            self.taskSubject = TasksDatabaseObject?.subject?.name!
        }else{
            self.taskSubject = "Не добавило"
        }
        
        if(TasksDatabaseObject?.date != nil){
            self.taskDate = CustomDateClass(withDate: (TasksDatabaseObject?.date)!)
        }else{
            self.taskDate = nil
        }
    }

}
