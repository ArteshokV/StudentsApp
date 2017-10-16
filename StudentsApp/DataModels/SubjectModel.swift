//
//  SubjectModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class SubjectModel: NSObject {
    var SubjectsDatabaseObject: Subjects?
    var subjectName: String?
    var subjectImage: UIImage?
    
    static func getSubjects() -> Array<SubjectModel>{
        //Получаем список предметов
        var returnArray: Array<SubjectModel> = Array()
        
        let fetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            for result in searchResults as [Subjects]{
                returnArray.append(SubjectModel(withDatabaseObject: result))
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }

    override init() {
        super.init()
    }
    
    init(withDatabaseObject: Subjects) {
        super.init()
        
        self.SubjectsDatabaseObject = withDatabaseObject
        
        self.subjectName = SubjectsDatabaseObject?.name
        
        
        if(SubjectsDatabaseObject?.image != nil){
            self.subjectImage = nil//SubjectsDatabaseObject?.image
        }else{
            self.subjectImage = nil
        }
    }
}
