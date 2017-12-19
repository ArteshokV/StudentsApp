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
            print("Printing respons data here: ")
            let encodeddata = try! encoder.encode(respons)
            print(String(data: encodeddata, encoding: .utf8)!)
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

