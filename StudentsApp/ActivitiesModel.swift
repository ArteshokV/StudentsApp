//
//  ActivitiesModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class ActivitiesModel: NSObject {
    var activityId: Int?
    var activityDate: Int?
    var activityNameShort: String?
    var activitySubject: String?
    //var taskPriority: Int?  <- НУЖНЫ ЛИ ЭТИ ПОЛЯ?
    //var taskDescription: String?
    //var taskStatus: Int?
    
    static func getActivities() -> Array<ActivitiesModel>{
        //Получаем список мероприятий
        var returnArray: Array<ActivitiesModel> = Array()
        
        let firstClass: ActivitiesModel = ActivitiesModel()
        let secondClass: ActivitiesModel = ActivitiesModel()
        
        returnArray.append(firstClass)
        returnArray.append(secondClass)
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
}
