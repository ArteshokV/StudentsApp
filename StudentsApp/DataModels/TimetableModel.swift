//
//  TimetableModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class TimetableModel: NSObject {
    var timeTableDatabaseObject: TimeTable?
    var classDate: CustomDateClass?
    var classStartTime: String?
    var classEndTime: String?
    var classSubject: String?
    var classTeacher: String?
    var classPlace: String?
    var classType: String?
    
    static func getTimetable(Date: CustomDateClass) -> Array<TimetableModel>{
        var returnArray: Array<TimetableModel> = Array()
        
        let parity = Date.weekNumber(fromStartDate: "01.09.2017") % 2 //0-четная, 1 - нечетная
        let selectionCondition: String = "dayOfWeek == \(Date.weekDayInt!)"
        //"(dayOfWeek == \(Date.weekDayInt!)) AND ((parity == \(parity)) OR (date == \(Date.currentDate!))"
        let predicate:NSPredicate = NSPredicate(format: selectionCondition)
        
        let fetchRequest:NSFetchRequest<TimeTable> = TimeTable.fetchRequest()
        fetchRequest.predicate = predicate
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            //print("number of results: \(searchResults.count)")
            
            for result in searchResults as [TimeTable]{
                //print("\(result.subject!.name!) \(result.place!) in \(result.startTime!) ")
                //let obj = TimetableModel(withDatabaseObject: result)
                returnArray.append(TimetableModel(withDatabaseObject: result))
                //print(obj)
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }
    
    func addClass() -> Bool {
        //Добавляем пару в БД
        return false
    }
    
    func deleteClass() -> Bool {
        //Удаляем пару из БД
        return false
    }
    
    func updateClass() -> Bool {
        //Обновляем пару в БД
        return false
    }
    
    override init() {
        super.init()
    }
    
    init(withDatabaseObject: TimeTable) {
        super.init()
        self.timeTableDatabaseObject = withDatabaseObject
        self.classStartTime = timeTableDatabaseObject?.startTime != nil ? timeTableDatabaseObject?.startTime! : nil;
        self.classEndTime = timeTableDatabaseObject?.endTime != nil ? timeTableDatabaseObject?.endTime! : nil;
        self.classTeacher = timeTableDatabaseObject?.teacher != nil ? timeTableDatabaseObject?.teacher! : nil;
        self.classPlace = timeTableDatabaseObject?.place != nil ? timeTableDatabaseObject?.place! : nil;
        self.classType = timeTableDatabaseObject?.type != nil ? timeTableDatabaseObject?.type : nil;
        
        self.classSubject = timeTableDatabaseObject?.subject != nil ? timeTableDatabaseObject?.subject!.name! : nil;
        self.classDate = timeTableDatabaseObject?.date != nil ? CustomDateClass(withDate: (timeTableDatabaseObject?.date)!) : nil;
    }
}

