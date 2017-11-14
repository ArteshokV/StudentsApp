//
//  TeacherModel.swift
//  StudentsApp
//
//  Created by Иван Галкин on 30.10.2017.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class TeacherModel: NSObject {
    let coreDataTabelName = String(describing: Teacher.self)
    var TeacherDatabaseObject: Teacher?
    var name: String?
    var familyName: String?
    var fatherName: String?
    var image: UIImage?
    var timeTableEvents: NSSet?
    
    static func getTeachers() -> Array<TeacherModel>{
        //Получаем список заданий
        var returnArray: Array<TeacherModel> = Array()
        
        let fetchRequest:NSFetchRequest<Teacher> = Teacher.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            for result in searchResults as [Teacher]{
                returnArray.append(TeacherModel(withDatabaseObject: result))
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }
    
    func save() -> Bool {
        
        if TeacherDatabaseObject == nil {
            return insertTeacher()
        }else{
            return updateTeacher()
        }
        
    }
    
    private func insertTeacher() -> Bool {
        //Добавляем задание в БД
        TeacherDatabaseObject = (NSEntityDescription.insertNewObject(forEntityName: coreDataTabelName, into: DatabaseController.getContext()) as! Teacher)
        return updateTeacher()
    }
    
    private func updateTeacher() -> Bool {
        //--- Populating entity with data from this object and if successful - saving context
        if populateEntityWithObjectData(){
            DatabaseController.saveContext()
            return true
        }else{
            return false
        }
    }
    
    
    func delete() -> Bool {
        //Удаляем задание из БД
        if TeacherDatabaseObject != nil {
            DatabaseController.getContext().delete(TeacherDatabaseObject!)
            DatabaseController.saveContext()
            TeacherDatabaseObject = nil
            return true
        }
        else{
            return false
        }
        
    }
    
    override init() {
        super.init()
    }
    
    init(Name:String, FamilyName:String, FatherName:String?){
        super.init()
        self.name = Name
        self.familyName = FamilyName
        self.fatherName = FatherName != nil ? FatherName : nil
        
        self.TeacherDatabaseObject = getOrCreateTeacher()
        
        
        //self.image = TeacherDatabaseObject?.image != nil ? UIImage(data:(TeacherDatabaseObject?.image!)!,scale:1.0) : nil;
        //self.timeTableEvents = NSSet()
    }
    
    init(withDatabaseObject: Teacher) {
        super.init()
        
        self.TeacherDatabaseObject = withDatabaseObject
        
        self.name = TeacherDatabaseObject?.name != nil ? TeacherDatabaseObject?.name! : nil;
        self.familyName = TeacherDatabaseObject?.familyName != nil ? TeacherDatabaseObject!.familyName : nil;
        self.fatherName = TeacherDatabaseObject?.fatherName != nil ? TeacherDatabaseObject?.fatherName! : nil;
        self.image = TeacherDatabaseObject?.image != nil ? UIImage(data:(TeacherDatabaseObject?.image!)!,scale:1.0) : nil;
        //self.timeTableEvents = TeacherDatabaseObject?.timeTable != nil ? TeacherDatabaseObject?.timeTable : nil;
        
    }
    
    //--- Before calling this make sure DB object is not nil, please)
    private func populateEntityWithObjectData() -> Bool {
        
        TeacherDatabaseObject?.name = self.name != nil ? self.name! : nil;
        TeacherDatabaseObject?.familyName = self.familyName != nil ? self.familyName! : nil;
        TeacherDatabaseObject?.fatherName = self.fatherName != nil ? self.fatherName! : nil;
        //TeacherDatabaseObject?.image = self.image != nil ? self.image! : nil;
        //TeacherDatabaseObject?.timeTable = self.timeTableEvents != nil ? self.timeTableEvents! : nil;
        
        return true
    }
    
    private func getOrCreateTeacher() -> Teacher? {
        
        let fetchRequest:NSFetchRequest<Teacher> = Teacher.fetchRequest()
        var Predicate:NSPredicate
        if self.fatherName == nil {
            Predicate = NSPredicate(format: "name == %@ AND familyName == %@ AND fatherName == nil", self.name!, self.familyName!)
        }
        else{
            Predicate = NSPredicate(format: "name == %@ AND familyName == %@ AND fatherName == %@", self.name!, self.familyName!, self.fatherName!)
        }
        
        fetchRequest.predicate = Predicate
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            // MARK: I am not so sure if this array can be nil, but xcode says that it can't so I'm not cheking...
            if (searchResults.count > 0){
                return searchResults.first!
            }
            else{
                let returnObject = (NSEntityDescription.insertNewObject(forEntityName: coreDataTabelName, into: DatabaseController.getContext()) as! Teacher)
                return returnObject
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return nil;
    }
    
    func getDataBaseEntity() -> Teacher? {
        if TeacherDatabaseObject != nil {
            return TeacherDatabaseObject!
        }
        else{
            //--- returns nil if ther was an error in getOrCreate
            return getOrCreateTeacher()
        }
    }
}










