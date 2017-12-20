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
        var syncdata:syncData? = syncData()
        syncdata?.mebileClientLastSyncDate = "\(UserDefaults.standard.double(forKey: "lastSyncDate"))"
        do{
            let selectedGroup = try JSONDecoder().decode(studyUnit.self, from: UserDefaults.standard.data(forKey: "selectedGroup")!)
            syncdata?.groupID = selectedGroup.id
        }catch{
            print("Unable to decode selectedJson")
        }
        syncdata?.toServerData = syncArraysSet()
        syncdata?.toServerData?.tasks = []
        let tasks = TaskModel.getTasksForSync()
        for mytask in tasks {
            var taskStruct:task? = task()
            
            taskStruct?.id = mytask.idOnServer
            taskStruct?.shortName = mytask.taskNameShort
            taskStruct?.date = mytask.taskDate?.stringFromDate()
            taskStruct?.subject = mytask.taskSubject != nil ? mytask.taskSubject : nil;
            taskStruct?.description = mytask.taskDescription
            taskStruct?.priority = mytask.taskPriority
            taskStruct?.status = mytask.taskStatus
            
            syncdata?.toServerData?.tasks?.append(taskStruct!)
            
        }
        
        syncdata?.toServerData?.activities = []
        
        syncdata?.toServerData?.teachers = []
        syncdata?.toServerData?.timeTableEvents = []
        syncdata?.toServerData?.subjects = []
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodeddata = try! encoder.encode(syncdata)
        print(String(data: encodeddata, encoding: .utf8)!)
        
        network.doSync(withCompletition: {(respons)
            in
            // Print response
            print("Printing respons data here: ")
            let encodeddata = try! encoder.encode(respons)
            print(String(data: encodeddata, encoding: .utf8)!)
            
            // Proccess response
            if respons?.returnedDueToNewIDs != nil {
                print("Proccessing returned due to new id...")
                let returnedDueToNewIds = respons!.returnedDueToNewIDs
                
                if ((returnedDueToNewIds!.tasks!.count) > 0) {
                    print("Proccessing tasks in returnedDueToNewIds...")
                    for tas in returnedDueToNewIds!.tasks! {
                        let taskModel = TaskModel.getTaskForRemoteIDAssigment(SortName: tas.shortName!, Subject: tas.subject!, Description: tas.description!)
                        if taskModel != nil {
                            taskModel?.idOnServer = tas.id
                            if (taskModel?.save())! {
                                print("Saved taskModel with new on-server id)")
                            }else{
                                print("Could't save taskModel with new on-serve id(")
                            }
                        }else{
                            print("Got nil taskModel while prossesing tasks in returnedDueToNewIds.")
                        }
                    }
                }
                else{
                    print("No tasks in returnedDueToNewIds.")
                }
                
            }else{
                print("No returned due to new ids.")
                
            }
            
            if respons?.returnedToSync != nil {
                print("Proccessing returned to sync...")
                
            }else{
                print("No returned to sync.")
                
            }
            
        }, dataToSend: String(data: encodeddata, encoding: .utf8)!)
    }
    
}

struct syncReturnDataStruct: Codable {
    var returnedDueToNewIDs:syncArraysSet?
    var returnedToSync:syncArraysSet?
    
}

struct syncData: Codable {
    //    {"teachers":[],"activities":[],"subjects":[],"tasks":[],"timeTableEvents":[]}
    var groupID:Int?
    var mebileClientLastSyncDate:String?
    var toServerData:syncArraysSet?
    var fromServerData:syncArraysSet?
}

struct syncArraysSet: Codable{
    var subjects: [subject]?
    var timeTableEvents: [timeTableEvent]?
    var teachers: [teacher]?
    var activities: [activity]?
    var tasks: [task]?
}

