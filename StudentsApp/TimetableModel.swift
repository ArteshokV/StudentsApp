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
    var classDate: Int?
    var classStartTime: Int?
    var classEndTime: Int?
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
        firstClass.classDate = 1
        firstClass.classStartTime = 1
        firstClass.classEndTime = 1
        firstClass.classSubject = "Информатика"
        firstClass.classTeacher = "Ялдакова"
        firstClass.classPlace = "515ю"
        firstClass.classType = "Лекция"
        let secondClass: TimetableModel = TimetableModel()
        secondClass.classId = 2
        secondClass.classDate = 1
        secondClass.classStartTime = 1
        secondClass.classEndTime = 1
        secondClass.classSubject = "Математика"
        secondClass.classTeacher = "Хуеплетов"
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
