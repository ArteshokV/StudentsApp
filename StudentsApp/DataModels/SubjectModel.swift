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
    static let coreDataTabelName = String(describing: Subjects.self)
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
        
        self.subjectName = SubjectsDatabaseObject?.name != nil ? SubjectsDatabaseObject?.name! : nil;
        self.subjectImage = SubjectsDatabaseObject?.image != nil ? UIImage(data:(SubjectsDatabaseObject?.image!)!,scale:1.0) : nil;
    }
    
    //---Mind you, this function does not save DB context and is intended to be used with CRUD functions of other data models!
    static func getOrCreateSubjectWith(Name:String) -> Subjects {
        let subjectByName = getSubjectBy(Name: Name)
        
        // MARK: I am not so sure if this array can be nil, but xcode says that it can't so I'm not cheking...
        if (subjectByName.count > 0){
            return subjectByName.first!
        }
        else{
            let returnObject = (NSEntityDescription.insertNewObject(forEntityName: coreDataTabelName, into: DatabaseController.getContext()) as! Subjects)
            returnObject.name = Name
            return returnObject
        }
    }
    
    static private func getSubjectBy(Name:String) -> Array<Subjects>{
        var returnArray: Array<Subjects> = Array()
        
        let fetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        let namePredicate = NSPredicate(format: "name == %@", Name)
        fetchRequest.predicate = namePredicate
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            returnArray = searchResults
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }
}
