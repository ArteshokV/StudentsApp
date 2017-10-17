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
    var ActivityDatabaseObject: Activities?
    var activityDate: CustomDateClass?
    var activityNameShort: String?
    var activitySubject: String?
    
    static func getActivities() -> Array<ActivitiesModel>{
        //Получаем список мероприятий
        var returnArray: Array<ActivitiesModel> = Array()
        
        let fetchRequest:NSFetchRequest<Activities> = Activities.fetchRequest()
        
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
    
    func addActivity() -> Bool {
        //Добавляем мероприятие в БД
        return false
    }
    
    func deleteActivity() -> Bool {
        //Удаляем мероприятие из БД
        return false
    }
    
    func updateActivity() -> Bool {
        //Обновляем мероприятие в БД
        return false
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
}
