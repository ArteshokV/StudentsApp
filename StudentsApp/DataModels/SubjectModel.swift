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
    var dateCreated: Double?
    var dateUpdated: Double?
    
    static func getSubjects() -> Array<SubjectModel>{
        //Получаем список предметов
        var returnArray: Array<SubjectModel> = Array()
        
        let fetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            for result in searchResults as [Subjects]{
                if(result.name != nil){
                    returnArray.append(SubjectModel(withDatabaseObject: result))
                }
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
        
        self.dateCreated = SubjectsDatabaseObject?.dateCreated != nil ? SubjectsDatabaseObject?.dateCreated : nil;
        self.dateUpdated = SubjectsDatabaseObject?.dateUpdated != nil ? SubjectsDatabaseObject?.dateUpdated : nil;
    }
    
    // MARK: - Subject CRUD Methods
    func save() -> Bool {
        
        if SubjectsDatabaseObject == nil {
            return insertSubject()
        }else{
            return updateSubject()
        }
        
    }
    
    private func insertSubject() -> Bool {
        //Добавляем задание в БД
        SubjectsDatabaseObject = (NSEntityDescription.insertNewObject(forEntityName: SubjectModel.coreDataTabelName, into: DatabaseController.getContext()) as! Subjects)
        return updateSubject()
    }
    
    private func updateSubject() -> Bool {
        //--- Populating entity with data from this object and if successful - saving context
        if self.dateCreated == nil {
            self.dateCreated = Date().timeIntervalSince1970
        }
        self.dateUpdated = Date().timeIntervalSince1970
        if populateEntityWithObjectData(){
            DatabaseController.saveContext()
            return true
        }else{
            return false
        }
    }
    
    
    func delete() -> Bool {
        //Удаляем задание из БД
        if SubjectsDatabaseObject != nil {
            DatabaseController.getContext().delete(SubjectsDatabaseObject!)
            DatabaseController.saveContext()
            SubjectsDatabaseObject = nil
            return true
        }
        else{
            return false
        }
        
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
            returnObject.dateCreated = Date().timeIntervalSince1970
            returnObject.dateUpdated = Date().timeIntervalSince1970
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
    
    //--- Before calling this make sure DB object is not nil, please)
    private func populateEntityWithObjectData() -> Bool {
        SubjectsDatabaseObject?.dateCreated = self.dateCreated!
        SubjectsDatabaseObject?.dateUpdated = self.dateUpdated!
        
        SubjectsDatabaseObject?.name = self.subjectName
        
        return true
    }
    
    // MARK: FetchController Setup
    
    static func setupFetchController() -> NSFetchedResultsController<Subjects>{
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Subjects.name), ascending: false)
        let SubjectsFetchRequest: NSFetchRequest<Subjects> = Subjects.fetchRequest()
        SubjectsFetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchController = NSFetchedResultsController(fetchRequest: SubjectsFetchRequest, managedObjectContext: DatabaseController.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchController.performFetch()
        return fetchController
    }
}
