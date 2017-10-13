//
//  SubjectModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class SubjectModel: NSObject {
    var subjectName: String?
    var subjectImage: UIImage?
    
    static func getSubjects() -> Array<SubjectModel>{
        //Получаем список предметов
        var returnArray: Array<SubjectModel> = Array()
        
        let firstClass: SubjectModel = SubjectModel()
        firstClass.subjectName = "Экология"
        firstClass.subjectImage = nil
        let secondClass: SubjectModel = SubjectModel()
        secondClass.subjectName = "Математика"
        secondClass.subjectImage = nil
        let thirdClass: SubjectModel = SubjectModel()
        thirdClass.subjectName = "Экономика"
        thirdClass.subjectImage = nil
        let forthClass: SubjectModel = SubjectModel()
        forthClass.subjectName = "Математический анализ и теория алгоритмов"
        forthClass.subjectImage = nil
        let fifthClass: SubjectModel = SubjectModel()
        fifthClass.subjectName = "Теория систем и системный анализ"
        fifthClass.subjectImage = nil
        let sixClass: SubjectModel = SubjectModel()
        sixClass.subjectName = "Программирование на C#"
        sixClass.subjectImage = nil
        
        returnArray.append(firstClass)
        returnArray.append(secondClass)
        returnArray.append(thirdClass)
        returnArray.append(forthClass)
        returnArray.append(fifthClass)
        returnArray.append(sixClass)
        
        return returnArray
    }

}
