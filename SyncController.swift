//
//  SyncController.swift
//  StudentsApp
//
//  Created by Иван Галкин on 24.11.2017.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import Foundation


class SyncController: NSObject {
    
    static func sync(){
        let network = NetworkClass()
        var data:initalDataResponse? = initalDataResponse()
        
        data?.tasks = []
        let tasks = TaskModel.getTasksForSync()
        for mytask in tasks {
            var taskStruct:task? = task()
            
            taskStruct?.id = 100
            taskStruct?.shortName = mytask.taskNameShort
            taskStruct?.date = mytask.taskDate?.stringFromDate()
            taskStruct?.subject = mytask.taskSubject != nil ? mytask.taskSubject : nil;
            taskStruct?.description = mytask.taskDescription
            taskStruct?.priority = mytask.taskPriority
            taskStruct?.status = mytask.taskStatus
            
            data?.tasks?.append(taskStruct!)
            
        }
        
        data?.activities = []
        
        data?.teachers = []
        data?.timeTableEvents = []
        data?.subjects = []
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodeddata = try! encoder.encode(data)
        print(String(data: encodeddata, encoding: .utf8)!)
        
        network.doSync(withCompletition: {(respons)
            in
            
        }, dataToSend: String(data: encodeddata, encoding: .utf8)!)
    }
    
}
