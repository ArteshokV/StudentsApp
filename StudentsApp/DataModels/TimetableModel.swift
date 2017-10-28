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
    let coreDataTabelName = String(describing: TimeTable.self)
    var timeTableDatabaseObject: TimeTable?
    var classDate: CustomDateClass?
    var classBeginDate: CustomDateClass?
    var classEndDate: CustomDateClass?
    var classStartTime: String?
    var classEndTime: String?
    var classSubject: String?
    var classTeacher: String?
    var classPlace: String?
    var classType: String?
    
    static func getTimetable(Date: CustomDateClass) -> Array<TimetableModel>{
        var returnArray: Array<TimetableModel> = Array()
        
        let parity = Date.weekNumber(fromStartDate: "01.09.2017") % 2 //0-четная, 1 - нечетная
        // get the current calendar
        let calendar = Calendar.init(identifier: .gregorian)
        // get the start of the day of the selected date
        let startDate = calendar.startOfDay(for: Date.currentDate!)
        // get the start of the day after the selected date
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        let selectionCondition: String = "(dayOfWeek == \(Date.weekDayInt!)) AND (parity == \(parity) OR parity == nil) OR ((date >= %@) AND (date < %@))"
        let predicate:NSPredicate = NSPredicate(format: selectionCondition,startDate as NSDate,endDate! as NSDate)
        print(predicate)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(TimeTable.startTime), ascending: true)
        
        let fetchRequest:NSFetchRequest<TimeTable> = TimeTable.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescriptor]
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
    
    func save() -> Bool {
        
        if timeTableDatabaseObject == nil {
            return insertClass()
        }else{
            return updateClass()
        }
        
    }
    
    private func insertClass() -> Bool {
        //Добавляем пару в БД
        //timeTableDatabaseObject = (NSEntityDescription.insertNewObject(forEntityName: coreDataTabelName, into: DatabaseController.getContext()) as! TimeTable)
        
        
        
        return false
    }
    
    private func updateClass() -> Bool {
        //Обновляем пару в БД
        return false
    }
    
    
    func deleteClass() -> Bool {
        //Удаляем пару из БД
        return false
    }
    
    override init() {
        super.init()
    }
    
    init(withDatabaseObject: TimeTable) {
        super.init()
        self.timeTableDatabaseObject = withDatabaseObject
        self.classStartTime = timeTableDatabaseObject?.startTime != nil ? DatabaseController.timeToStringForm(Int: (timeTableDatabaseObject?.startTime)!) : nil;
        self.classEndTime = timeTableDatabaseObject?.endTime != nil ? DatabaseController.timeToStringForm(Int: (timeTableDatabaseObject?.endTime)!) : nil;
        self.classTeacher = timeTableDatabaseObject?.teacher != nil ? timeTableDatabaseObject?.teacher! : nil;
        self.classPlace = timeTableDatabaseObject?.place != nil ? timeTableDatabaseObject?.place! : nil;
        self.classType = timeTableDatabaseObject?.type != nil ? timeTableDatabaseObject?.type : nil;
        
        self.classSubject = timeTableDatabaseObject?.subject != nil ? timeTableDatabaseObject?.subject!.name! : nil;
        self.classDate = timeTableDatabaseObject?.date != nil ? CustomDateClass(withDate: (timeTableDatabaseObject?.date)!) : nil;
        self.classBeginDate = timeTableDatabaseObject?.beginDate != nil ? CustomDateClass(withDate: (timeTableDatabaseObject?.beginDate)!) : nil;
        self.classEndDate = timeTableDatabaseObject?.endDate != nil ? CustomDateClass(withDate: (timeTableDatabaseObject?.endDate)!) : nil;
    }
    
    //--- Before calling this make sure DB object is not nil, please)
    private func populateEntityWithObjectData() -> Bool {
        //--- Handle convertion for time from str to int16
        timeTableDatabaseObject?.startTime = timeStringToInt(str: self.classStartTime!)
        timeTableDatabaseObject?.endTime = timeStringToInt(str: self.classEndTime!)
        timeTableDatabaseObject?.teacher = self.classTeacher
        timeTableDatabaseObject?.place = self.classPlace
        timeTableDatabaseObject?.type = self.classType
        //--- Handle getting subject as DB object
        timeTableDatabaseObject?.subject = self.classSubject
        timeTableDatabaseObject?.date = self.classDate != nil ? self.classDate?.currentDate : nil;
        timeTableDatabaseObject?.beginDate = self.classBeginDate != nil ? self.classBeginDate?.currentDate : nil;
        timeTableDatabaseObject?.endDate = self.classEndDate != nil ? self.classEndDate?.currentDate : nil;
        
        return true
    }
    
    private func timeStringToInt(str: String) -> Int16{
        let indexTo = str.index(str.startIndex, offsetBy: 1)
        let leftStr = str[...indexTo]
        let indexFrom = str.index(str.startIndex, offsetBy: 3)
        let rightStr = str[indexFrom...]
        return Int16("\(leftStr)\(rightStr)")!
    }
}

