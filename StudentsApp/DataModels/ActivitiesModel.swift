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
        
        self.activityNameShort = ActivityDatabaseObject?.shortName
        
        if(ActivityDatabaseObject?.date != nil){
            self.activityDate = CustomDateClass(withDate: (ActivityDatabaseObject?.date)!)
        }else{
            self.activityDate = nil
        }
        
        if(ActivityDatabaseObject?.subject != nil){
            self.activitySubject = ActivityDatabaseObject?.subject?.name!
        }else{
            self.activitySubject = "Не добавило"
        }
    }
}
