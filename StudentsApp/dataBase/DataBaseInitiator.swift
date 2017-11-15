//
//  DataBaseInitiator.swift
//  StudentsApp
//
//  Created by Иван Галкин on 13.10.2017.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class DataBaseInitiator: NSObject {
    
    let subjectsDatabaseName = String(describing: Subjects.self)
    let timeTableDatabaseName = String(describing: TimeTable.self)
    let activitiesDatabaseName = String(describing: Activities.self)
    let tasksDatabaseName = String(describing: Tasks.self)

    func deleteDatabase(){
        for entity in DatabaseController.persistentContainer.managedObjectModel.entities {
            if let entityName = entity.name {
                if(entityName == "AppLook"){continue}
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                do {
                    try DatabaseController.getContext().execute(NSBatchDeleteRequest(fetchRequest: fetchRequest))
                }
                catch {
                    print(error)
                }
            }
        }
        
        DatabaseController.saveContext()
    }
    
    func updateViews(){
        //For updating views
        let updateTasks = TaskModel()
        updateTasks.taskPriority = 0
        updateTasks.taskStatus = 0
        updateTasks.taskSubject = "NO"
        updateTasks.save()
        updateTasks.delete()
        let updateClasses = TimetableModel()
        updateClasses.classStartTime = "08:20"
        updateClasses.classEndTime = "08:20"
        updateClasses.classSubject = "NO"
        updateClasses.save()
        updateClasses.delete()
    }
    
    func databaseIsEmpty() -> Bool{
        let fetchRequest:NSFetchRequest<TimeTable> = TimeTable.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            if(searchResults.count != 0){return false}
        }
        catch{
            print("Error: \(error)")
        }
        return true
    }
    
    //---if check isnot nil and is true the stored data will be dumped to console for manual verification
    func insertInitialData(withParsedStruct: initalDataResponse?) {
        let dataStruct = withParsedStruct!
        var numberOfSearchResults = 0
        
        let fetchRequest:NSFetchRequest<TimeTable> = TimeTable.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            numberOfSearchResults = searchResults.count
            //for result in searchResults as [TimeTable]{
            //print("\(result.beginDate) \(result.type)")
            //}
        }
        catch{
            print("Error: \(error)")
        }
        
        
        
        if(numberOfSearchResults != 0){
            deleteDatabase()
        }
        
        //FIXME: store teachers maybe....
        //--- Storing Subjects
        for subject in dataStruct.subjects!{
                //print(DatabaseController.getContext())
                let Subject:Subjects = NSEntityDescription.insertNewObject(forEntityName: subjectsDatabaseName, into: DatabaseController.getContext()) as! Subjects
                Subject.name = subject.name
            }
            DatabaseController.saveContext()
            
            //---Storing TimeTable
        
        for eventData in dataStruct.timeTableEvents!{
                
                let event:TimeTable = NSEntityDescription.insertNewObject(forEntityName: timeTableDatabaseName, into: DatabaseController.getContext()) as! TimeTable
                
                event.startTime = eventData.startTime
                event.endTime = eventData.endTime
                
                
                event.place = eventData.place
                event.type = eventData.type
                if !(eventData.beginDate == nil){
                    event.beginDate = CustomDateClass(withString: eventData.beginDate!).currentDate
                }
                if !(eventData.endDate == nil){
                    event.endDate = CustomDateClass(withString: eventData.endDate!).currentDate
                }
                if !(eventData.dayOfWeek == nil){
                    event.dayOfWeek = eventData.dayOfWeek! as NSNumber
                }
                if !(eventData.parity == nil){
                    event.parity = eventData.parity! as NSNumber
                }
                if !(eventData.date == nil){
                    event.date = CustomDateClass(withString: eventData.date!).currentDate
                }
                
                event.subject = getSubjectBy(Name: eventData.subject)
                if eventData.teacher == nil {
                    event.teacher = nil
                    DatabaseController.saveContext()
                }
                else{
                    let teacher:TeacherModel = TeacherModel(Name: (eventData.teacher)!.name, FamilyName: (eventData.teacher?.familyName)!, FatherName: eventData.teacher?.fatherName == nil ? nil : eventData.teacher?.fatherName)
                    teacher.save()
                    event.teacher = teacher.getDataBaseEntity()
                    
                }
            }
            DatabaseController.saveContext()
 
            //---Storing Activities
        
        for activity in dataStruct.activities!{
                
                let event:Activities = NSEntityDescription.insertNewObject(forEntityName: activitiesDatabaseName, into: DatabaseController.getContext()) as! Activities
                
                event.date = CustomDateClass(withString: activity.date).currentDate
                
                event.shortName = activity.shortName
                
                event.subject = getSubjectBy(Name: activity.subject)
            }
        
            //---Storing Tasks
        for task in dataStruct.tasks!{
                
                let event:Tasks = NSEntityDescription.insertNewObject(forEntityName: tasksDatabaseName, into: DatabaseController.getContext()) as! Tasks
                
                event.date = CustomDateClass(withString: task.date).currentDate
                event.shortName = task.shortName
                event.descrp = task.description
                event.priority = (task.priority)
                event.status = (task.status )
                
                event.subject = getSubjectBy(Name: task.subject)
            }
        
            DatabaseController.saveContext()
        
        updateViews()
        
        UserDefaults.standard.set(true, forKey: "databaseIsInited")
        //doCheck()
    }
    
    func getSubjectBy(Name: String) -> Subjects {
        let subjectsDatabaseName:String = String(describing: Subjects.self)
        let SubjectFetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        SubjectFetchRequest.predicate = NSPredicate(format: "name == %@", Name)
        var res:[Subjects]?
        do{
            res = try DatabaseController.getContext().fetch(SubjectFetchRequest)
            if(res?.count == 0){
                let Subject:Subjects = NSEntityDescription.insertNewObject(forEntityName: subjectsDatabaseName, into: DatabaseController.getContext()) as! Subjects
                Subject.name = Name
                res?.append(Subject)
            }
            else{
                ///lallala
            }
        }catch{
            print("error geting subjects by name \(error.localizedDescription)")
        }
        return (res?[0])!
    }
    
    func store(Subjects: [String: [String:Any]]) {
        let subjectsDatabaseName:String = String(describing: Subjects.self)
        for record in Subjects.values{
            print(DatabaseController.getContext())
            let Subject:Subjects = NSEntityDescription.insertNewObject(forEntityName: subjectsDatabaseName, into: DatabaseController.getContext()) as! Subjects
            Subject.name = record["Name"] as? String
        }
        DatabaseController.saveContext()
    }
    
    
    
    func doCheck() {
        print("************************** Starting the data dump here ************************************")
        
        print("")
        print("** Dumping Time Table entity ...")
        let timeTableFetchRequest: NSFetchRequest<TimeTable> = TimeTable.fetchRequest()
        do{
            let timeTableEvents = try DatabaseController.getContext().fetch(timeTableFetchRequest)
            for ttEvent in timeTableEvents {
                print("\(String(describing: ttEvent.date)) \(ttEvent.startTime) \(ttEvent.endTime) \(String(describing: ttEvent.subject?.name)) \(String(describing: ttEvent.teacher)) \(ttEvent.place!) \(ttEvent.type!) \(String(describing: ttEvent.beginDate )) \(String(describing: ttEvent.endDate )) \(ttEvent.dayOfWeek) \(ttEvent.parity)")
            }
        }catch{
            print("** Error while dumping Time Table")
        }
        
        print("")
        print("** Dumping Task entity ...")
        let tasksFetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        do{
            let tasks = try DatabaseController.getContext().fetch(tasksFetchRequest)
            for task in tasks {
                print("\(task.date!) \(task.shortName!) \(task.descrp!) \(String(describing: task.subject?.name!)) \(task.priority) \(task.status)")
            }
        }catch{
            print("** Error while dumping Tasks")
        }
        
        print("")
        print("** Dumping Activities entity ...")
        let activitiesFetchRequest: NSFetchRequest<Activities> = Activities.fetchRequest()
        do{
            let activities = try DatabaseController.getContext().fetch(activitiesFetchRequest)
            for activity in activities {
                print("\(activity.date!) \(activity.shortName!) \(String(describing: activity.subject?.name!))")
            }
        }catch{
            print("** Error while dumping Activities")
        }
        
        print("")
        print("** Dumping Subjects entity ...")
        let subjectsFetchRequest: NSFetchRequest<Subjects> = Subjects.fetchRequest()
        do{
            let subjects = try DatabaseController.getContext().fetch(subjectsFetchRequest)
            for subject in subjects {
                print("\(subject.name!)")
            }
        }catch{
            print("** Error while dumping Subjects")
        }
        
        print("")
        print("** Dumping Teacher entity ...")
        let teacherFetchRequest: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        do{
            let teachers = try DatabaseController.getContext().fetch(teacherFetchRequest)
            for teacher in teachers {
                print("\(teacher.name!)")
            }
        }catch{
            print("** Error while dumping Teachers")
        }

        print("************************** The end of data dump *******************************************")
    }
    
    func initStandartAppLooks(){
        let appLookTableDatabaseName:String = String(describing: AppLook.self)
        //DARK LOOK
        let darkLook:AppLook = NSEntityDescription.insertNewObject(forEntityName: appLookTableDatabaseName, into: DatabaseController.getContext()) as! AppLook
        
        darkLook.lookName = "Dark"
        darkLook.backGroundImage = nil
        
        darkLook.gradientUpperColor = UIColor.darkGray
        darkLook.gradientLowerColor = UIColor.black
        
        darkLook.mainTextColor = UIColor.white
        darkLook.subTextColor = UIColor.lightGray
        
        darkLook.tabBarColor = UIColor.black.withAlphaComponent(0.4)
        darkLook.underLayerColor = UIColor.lightGray.withAlphaComponent(0.2)
        darkLook.blurViewStyle = "dark"
        
        darkLook.isSelected = true
        
        //GRAY LOOK
        let grayLook:AppLook = NSEntityDescription.insertNewObject(forEntityName: appLookTableDatabaseName, into: DatabaseController.getContext()) as! AppLook
        
        grayLook.lookName = "Gray"
        grayLook.backGroundImage = nil
        
        grayLook.gradientUpperColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.4)
        grayLook.gradientLowerColor = UIColor.lightGray.withAlphaComponent(0.4)
        
        grayLook.mainTextColor = UIColor.darkText
        grayLook.subTextColor = UIColor.darkGray
        
        grayLook.tabBarColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 0.6)
        grayLook.underLayerColor = UIColor.white.withAlphaComponent(0.9)
        grayLook.blurViewStyle = "dark"
        
        grayLook.isSelected = false
        
        //LIGHT LOOK
        let lightLook:AppLook = NSEntityDescription.insertNewObject(forEntityName: appLookTableDatabaseName, into: DatabaseController.getContext()) as! AppLook
        
        lightLook.lookName = "Light"
        lightLook.backGroundImage = nil
        
        lightLook.gradientUpperColor = UIColor.lightGray
        lightLook.gradientLowerColor = UIColor.white
        
        lightLook.mainTextColor = UIColor.darkText
        lightLook.subTextColor = UIColor.darkGray
        
        lightLook.tabBarColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 0.6)
        lightLook.underLayerColor = UIColor.lightGray.withAlphaComponent(0.4)
        lightLook.blurViewStyle = "light"
        
        lightLook.isSelected = false
        
        DatabaseController.saveContext()
        UserDefaults.standard.set(true, forKey: "appLooksInited")
    }
    
}

