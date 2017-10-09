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
    var classDate: String?
    var classStartTime: Int?
    var classEndTime: Int?
    var classSubject: String?
    var classTeacher: String?
    var classPlace: String?
    var classType: String?
    
    static func getTimetable(Date: String) -> Array<TimetableModel>{
        //Получаем расписание
        var currentArray: Array<TimetableModel> = Array()
        var returnArray: Array<TimetableModel> = Array()
        //var dfk: Date?
        
        let firstClass: TimetableModel = TimetableModel()
        firstClass.classId = 1
        firstClass.classDate = "October 10, 2017"
        firstClass.classStartTime = 1015
        firstClass.classEndTime = 1150
        firstClass.classSubject = "Информатика"
        firstClass.classTeacher = "Петров"
        firstClass.classPlace = "515ю"
        firstClass.classType = "Лекция"
        let secondClass: TimetableModel = TimetableModel()
        secondClass.classId = 2
        secondClass.classDate = "October 17, 2017"
        secondClass.classStartTime = 1
        secondClass.classEndTime = 1
        secondClass.classSubject = "Математика"
        secondClass.classTeacher = "Хартов"
        secondClass.classPlace = "315л"
        secondClass.classType = "Семинар"
        let thirdClass: TimetableModel = TimetableModel()
        thirdClass.classId = 3
        thirdClass.classDate = "October 10, 2017"
        thirdClass.classStartTime = 1200
        thirdClass.classEndTime = 1335
        thirdClass.classSubject = "Английский"
        thirdClass.classTeacher = "Каримова"
        thirdClass.classPlace = "433л"
        thirdClass.classType = "Семинар"
        
        currentArray.append(firstClass)
        currentArray.append(secondClass)
        
        for currentClass in currentArray {
            if (currentClass.classDate == Date) {
                returnArray.append(currentClass)
            }
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
