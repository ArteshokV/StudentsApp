//
//  ActivitiesModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesModel: NSObject {
    let coreDataTabelName = String(describing: Activities.self)
    var ActivityDatabaseObject: Activities?
    var activityDate: CustomDateClass?
    var activityNameShort: String?
    var activitySubject: String?
    
    static func getActivitiesForToday() -> Array<ActivitiesModel>{
        //Получаем список мероприятий на ближайшие 3 дня
        var returnArray: Array<ActivitiesModel> = Array()
        
        let todayDate = CustomDateClass()
        let tomorrowDate = CustomDateClass()
        tomorrowDate.switchToNextDay()
        tomorrowDate.switchToNextDay()
        let selectionCondition: String = "(date >= %@) AND (date <= %@)"
        let predicate:NSPredicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate, tomorrowDate.endOfDay() as NSDate)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Activities.date), ascending: true)
        
        let fetchRequest:NSFetchRequest<Activities> = Activities.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        //fetchRequest.fetchLimit = 3
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            for result in searchResults as [Activities]{
                returnArray.append(ActivitiesModel(withDatabaseObject: result))
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }
    
    static func getActivitiesGroupedByDate() -> [[ActivitiesModel]] {
        var returnArray = [[ActivitiesModel]]()
        let fetchRequest:NSFetchRequest<Activities> = Activities.fetchRequest()
        let sortDesrt = NSSortDescriptor(key: #keyPath(Activities.date), ascending: true)
        fetchRequest.sortDescriptors = [sortDesrt]
        do{
            let activities = try DatabaseController.getContext().fetch(fetchRequest)
            //---Creating random date to be able to start the loop
            var dateComponents = DateComponents()
            dateComponents.year = 1975
            var oldDate:Date = Calendar.current.date(from: dateComponents)!
            var tmpArray = [ActivitiesModel]()
            for activity in activities {
                let oder = Calendar.current.compare(activity.date!, to: oldDate, toGranularity: .day)
                
                //---Checking if this activity has the same date as the last one
                if oder != .orderedSame {
                    if tmpArray.count != 0 {
                        returnArray.append(tmpArray)
                    }
                    tmpArray = [ActivitiesModel]()
                    tmpArray.append(ActivitiesModel(withDatabaseObject: activity))
                }
                else{
                    tmpArray.append(ActivitiesModel(withDatabaseObject: activity))
                }
                oldDate = activity.date!
            }
        }catch{
            print("Error getting activities grouped by date. \(error.localizedDescription)")
        }
        return returnArray
    }
    
    static func getActivitiesGroupedBySubject() -> [[ActivitiesModel]] {
        var returnArray = [[ActivitiesModel]]()
        
        let fetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        
        do{
            //---Get all subjects... sorted, etc.
            let sortDescr = NSSortDescriptor(key: #keyPath(Subjects.name), ascending: true)
            fetchRequest.sortDescriptors = [sortDescr]
            let subjects = try DatabaseController.getContext().fetch(fetchRequest)
            
            //---fillout the res array
            for subject in subjects {
                
                var tmpArray: Array<ActivitiesModel> = Array<ActivitiesModel>()
                let searchResults = (subject.activities?.allObjects as! [Activities]).sorted(by: {$0.date! < $1.date!})
                if searchResults.count > 0 {
                    for result in searchResults as [Activities]{
                        
                        tmpArray.append(ActivitiesModel(withDatabaseObject: result))
                    }
                    
                    returnArray.append(tmpArray)
                }
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }
    
    
    
    func save() -> Bool {
        
        if ActivityDatabaseObject == nil {
            return insertActivity()
        }else{
            return updateActivity()
        }
        
    }
    
    private func insertActivity() -> Bool {
        //Добавляем мероприятие в БД
        ActivityDatabaseObject = (NSEntityDescription.insertNewObject(forEntityName: coreDataTabelName, into: DatabaseController.getContext()) as! Activities)
        return updateActivity()
    }
    
    private func updateActivity() -> Bool {
        //--- Populating entity with data from this object and if successful - saving context
        if populateEntityWithObjectData(){
            DatabaseController.saveContext()
            return true
        }else{
            return false
        }
    }
    
    
    func delete() -> Bool {
        //Удаляем мероприятие из БД
        if ActivityDatabaseObject != nil {
            DatabaseController.getContext().delete(ActivityDatabaseObject!)
            DatabaseController.saveContext()
            ActivityDatabaseObject = nil
            return true
        }
        else{
            return false
        }
        
    }
    
    override init() {
        super.init()
    }
    
    init(withDatabaseObject: Activities) {
        super.init()
        
        self.ActivityDatabaseObject = withDatabaseObject
        
        self.activityNameShort = ActivityDatabaseObject?.shortName != nil ? ActivityDatabaseObject?.shortName! : nil;
        self.activitySubject = ActivityDatabaseObject?.subject != nil ? ActivityDatabaseObject?.subject!.name! : nil;
        self.activityDate = ActivityDatabaseObject?.date != nil ? CustomDateClass(withDate: (ActivityDatabaseObject?.date)!) : nil;
    }
    
    //--- Before calling this make sure DB object is not nil, please)
    private func populateEntityWithObjectData() -> Bool {
        ActivityDatabaseObject?.shortName = self.activityNameShort
        ActivityDatabaseObject?.date = self.activityDate != nil ? self.activityDate?.currentDate : nil;
        
        //--- Handle getting subject as DB object
        if (ActivityDatabaseObject?.subject != nil) && (ActivityDatabaseObject?.subject?.name == self.activitySubject) {
            //---Well... Do nothing, it is the same subject)...
        }else{
            ActivityDatabaseObject?.subject = SubjectModel.getOrCreateSubjectWith(Name: self.activitySubject!)
        }
        
        return true
    }
}
