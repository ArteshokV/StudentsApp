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
        
        
        
        if(numberOfSearchResults != 0){return}
        
        do{
            let timeTableDatabaseName:String = String(describing: TimeTable.self)
            let url = Bundle.main.url(forResource: "InitialDataForDB", withExtension: "json")
            let data = try Data(contentsOf: url!)
            var json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            
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
                
                event.subject?.name = record["Subject"] as? String
                
            }
            
            
            DatabaseController.saveContext()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}

