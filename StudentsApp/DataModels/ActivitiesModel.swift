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
    var activityDate: CustomDateClass?
    var activityNameShort: String?
    var activitySubject: String?
    //var taskPriority: Int?  <- НУЖНЫ ЛИ ЭТИ ПОЛЯ?
    //var taskDescription: String?
    //var taskStatus: Int?
    
    static func getActivities() -> Array<ActivitiesModel>{
        //Получаем список мероприятий
        var returnArray: Array<ActivitiesModel> = Array()
        
        let firstClass: ActivitiesModel = ActivitiesModel()
        firstClass.activityId = 0
        firstClass.activityDate = CustomDateClass(withString: "03.10.17")
        firstClass.activityNameShort = "РК1"
        firstClass.activitySubject = "ТСиСА"
        let secondClass: ActivitiesModel = ActivitiesModel()
        secondClass.activityId = 1
        secondClass.activityDate = CustomDateClass(withString: "05.10.17")
        secondClass.activityNameShort = "РК1"
        secondClass.activitySubject = "Экономика"
        let thirdClass: ActivitiesModel = ActivitiesModel()
        thirdClass.activityId = 2
        thirdClass.activityDate = CustomDateClass(withString: "17.10.17")
        thirdClass.activityNameShort = "РК1"
        thirdClass.activitySubject = "Программирование"
        let fourthClass: ActivitiesModel = ActivitiesModel()
        fourthClass.activityId = 3
        fourthClass.activityDate = CustomDateClass(withString: "17.10.17")
        fourthClass.activityNameShort = "РК3"
        fourthClass.activitySubject = "Экономика"
        let fifthClass: ActivitiesModel = ActivitiesModel()
        fifthClass.activityId = 4
        fifthClass.activityDate = CustomDateClass(withString: "19.10.17")
        fifthClass.activityNameShort = "РК2"
        fifthClass.activitySubject = "Экология"
        let sixthClass: ActivitiesModel = ActivitiesModel()
        sixthClass.activityId = 5
        sixthClass.activityDate = CustomDateClass(withString: "14.10.17")
        sixthClass.activityNameShort = "РК1"
        sixthClass.activitySubject = "Экология"
        let seventhClass: ActivitiesModel = ActivitiesModel()
        seventhClass.activityId = 6
        seventhClass.activityDate = CustomDateClass(withString: "11.10.17")
        seventhClass.activityNameShort = "РК2"
        seventhClass.activitySubject = "Экономика"
        
        
        
        returnArray.append(firstClass)
        returnArray.append(secondClass)
        returnArray.append(thirdClass)
        returnArray.append(fourthClass)
        returnArray.append(fifthClass)
        returnArray.append(sixthClass)
        returnArray.append(seventhClass)
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
