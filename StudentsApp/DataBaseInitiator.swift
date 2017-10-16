//
//  DataBaseInitiator.swift
//  StudentsApp
//
//  Created by Иван Галкин on 13.10.2017.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import Foundation
import CoreData

class DataBaseInitiator: NSObject {
    
    func insertInitialData() {
        var numberOfSearchResults = 0
        
        let fetchRequest:NSFetchRequest<TimeTable> = TimeTable.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            numberOfSearchResults = searchResults.count
            //for result in searchResults as [TimeTable]{
            //print("\(result.beginDate) \(result.type)")
            //}
        }
        catch{
            print("Error: \(error)")
        }
        
        
        
        if(numberOfSearchResults != 0){
            print("Первичный загрузчик данных обнаружил данные в базе и завершил работу. Если вы хотели загрузить данные снуля - переустановите приложение...")
            return
        }
        
        do{
            let timeTableDatabaseName:String = String(describing: TimeTable.self)
            let url = Bundle.main.url(forResource: "InitialDataForDB", withExtension: "json")
            let data = try Data(contentsOf: url!)
            var json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            
            let subjectsInitalData = json["Subjects"] as! [String: [String:Any]]
            store(Subjects: subjectsInitalData)
            
            //---Storing TimeTable
            let timeTableJson = json["Timetable"] as! [String: [String:Any]]
            //json = json["1"] as! [String: Any]
            //print(json["Date"] as! NSNull)
            
            for record in timeTableJson.values{
                
                let event:TimeTable = NSEntityDescription.insertNewObject(forEntityName: timeTableDatabaseName, into: DatabaseController.getContext()) as! TimeTable
                /*
                 "Date": null,
                 "StartTime": "10:15",
                 "EndTime": "11:50",
                 "Subject": "Экономика",
                 "Teacher": "Павлов В.А.",
                 "Place": "515ю",
                 "classType": "Лекция",
                 "StartDate": "01.09.2017",
                 "EndDate": "31.12.2017",
                 "weekDay": 2,
                 "Parity": true
                 */
                event.startTime = record["StartTime"] as? String
                event.endTime = record["EndTime"] as? String
                event.teacher = record["Teacher"] as? String
                event.place = record["Place"] as? String
                event.type = record["classType"] as? String
                if !(record["StartDate"] is NSNull){
                    event.beginDate = CustomDateClass(withString: record["StartDate"] as! String).currentDate
                }
                if !(record["EndDate"] is NSNull){
                    event.endDate = CustomDateClass(withString: record["EndDate"] as! String).currentDate
                }
                if !(record["weekDay"] is NSNull){
                    event.dayOfWeek = record["weekDay"] as! Int16
                }
                if !(record["Parity"] is NSNull){
                    event.parity = record["Parity"] as! Bool
                }
                if !(record["Date"] is NSNull){
                    event.date = CustomDateClass(withString: record["Date"] as! String).currentDate
                }
                
                event.subject = getSubjectBy(Name: record["Subject"] as! String)
                
            }
            
            //---Storing Activities
            let tasks = json["Tasks"] as! [String: [String:Any]]
            //json = json["1"] as! [String: Any]
            //print(json["Date"] as! NSNull)
            
            for record in tasks.values{
                
                let event:Activities = NSEntityDescription.insertNewObject(forEntityName: timeTableDatabaseName, into: DatabaseController.getContext()) as! Activities
                
                event.date = CustomDateClass(withString: record["Date"] as! String).currentDate
                event.shortName = record["nameShort"] as? String
                
                event.subject = getSubjectBy(Name: record["Subject"] as! String)
            }
            
            //---Storing Tasks
            let activities = json["Activities"] as! [String: [String:Any]]
            //json = json["1"] as! [String: Any]
            //print(json["Date"] as! NSNull)
            
            for record in activities.values{
                
                let event:Tasks = NSEntityDescription.insertNewObject(forEntityName: timeTableDatabaseName, into: DatabaseController.getContext()) as! Tasks
                
                event.date = CustomDateClass(withString: record["edgeDate"] as! String).currentDate
                event.shortName = record["nameShort"] as? String
                event.descrp = record["descriptionOfTask"] as? String
                event.priority = (record["Priority"] as? Int16)!
                event.status = (record["Status"] as? Int16)!
                
                event.subject = getSubjectBy(Name: record["Subject"] as! String)
            }
            
            DatabaseController.saveContext()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func getSubjectBy(Name: String) -> Subjects {
        let SubjectFetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        SubjectFetchRequest.predicate = NSPredicate(format: "name == %@", Name)
        var res:[Subjects]?
        do{
            res = try DatabaseController.getContext().fetch(SubjectFetchRequest)
            if(res?.count == 0){
                let Subject:Subjects = NSEntityDescription.insertNewObject(forEntityName: "Subjects", into: DatabaseController.getContext()) as! Subjects
                Subject.name = Name
                res?.append(Subject)
            }
            else{
                ///lallala
            }
        }catch{
            print("error geting subjects by name \(error.localizedDescription)")
        }
        return (res?[0])!
    }
    
    func store(Subjects: [String: [String:Any]]) {
        for record in Subjects.values{
            let Subject:Subjects = NSEntityDescription.insertNewObject(forEntityName: "Subjects", into: DatabaseController.getContext()) as! Subjects
            Subject.name = record["Name"] as? String
        }
        DatabaseController.saveContext()
    }
}

