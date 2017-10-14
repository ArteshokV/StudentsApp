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
    
    static func getTimetable(Date: CustomDateClass) -> Array<TimetableModel>{
        //Получаем расписание
        var currentArray: Array<TimetableModel> = Array()
        var returnArray: Array<TimetableModel> = Array()
        //var dfk: Date?
        let checkdate = CustomDateClass(withString: CustomDateClass().stringFromDate())
        
        let firstClass: TimetableModel = TimetableModel()
        firstClass.classId = 1
        firstClass.classDate = CustomDateClass(withString: "12.10.2017")
        firstClass.classStartTime = "10:15"
        firstClass.classEndTime = "11:50"
        firstClass.classSubject = "Информатика"
        firstClass.classTeacher = "Петров"
        firstClass.classPlace = "515ю"
        firstClass.classType = "Лекция"
        let secondClass: TimetableModel = TimetableModel()
        secondClass.classId = 2
        secondClass.classDate = CustomDateClass(withString: "19.10.2017")
        secondClass.classStartTime = "10:15"
        secondClass.classEndTime = "11:50"
        secondClass.classSubject = "Математика"
        secondClass.classTeacher = "Хартов"

        secondClass.classPlace = "315л"
        secondClass.classType = "Семинар"
        let thirdClass: TimetableModel = TimetableModel()
        thirdClass.classId = 3
        thirdClass.classDate = CustomDateClass(withString: "12.10.2017")
        thirdClass.classStartTime = "12:00"
        thirdClass.classEndTime = "13:35"
        thirdClass.classSubject = "Английский"
        thirdClass.classTeacher = "Каримова"
        thirdClass.classPlace = "433л"
        thirdClass.classType = "Семинар"
        
        currentArray.append(firstClass)
        currentArray.append(secondClass)
        currentArray.append(thirdClass)
        
        var i = 0
        
        while i != currentArray.count {
            if  checkdate.currentDate == Date.currentDate {
                returnArray.append(currentArray[i])
            }
            i = i + 1
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
}
