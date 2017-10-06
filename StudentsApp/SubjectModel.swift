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
        let secondClass: SubjectModel = SubjectModel()
        
        returnArray.append(firstClass)
        returnArray.append(secondClass)
        
        return returnArray
    }

}
