//
//  TimetableModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TimetableModel: NSObject {
    var classId: Int?
    var classDate: CustomDateClass?
    var classStartTime: String?
    var classEndTime: String?
    var classSubject: String?
    var classTeacher: String?
    var classPlace: String?
    var classType: String?
    
    static func getTimetable() -> Array<TimetableModel>{
        //Получаем расписание
        var returnArray: Array<TimetableModel> = Array()
        //var dfk: Date?
        
        let firstClass: TimetableModel = TimetableModel()
        firstClass.classId = 1
        firstClass.classDate = CustomDateClass(withString: "14.09.17")
        firstClass.classStartTime = "12:00"
        firstClass.classEndTime = "13:35"
        firstClass.classSubject = "Информатика"
        firstClass.classTeacher = "Булдакова"
        firstClass.classPlace = "515ю"
        firstClass.classType = "Лекция"
        let secondClass: TimetableModel = TimetableModel()
        secondClass.classId = 2
        secondClass.classDate = CustomDateClass(withString: "14.09.17")
        secondClass.classStartTime = "13:50"
        secondClass.classEndTime = "15:25"
        secondClass.classSubject = "Математика"
        secondClass.classTeacher = "Мамаев"
        secondClass.classPlace = "315л"
        secondClass.classType = "Семинар"
        
        returnArray.append(firstClass)
        returnArray.append(secondClass)
        
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
}
