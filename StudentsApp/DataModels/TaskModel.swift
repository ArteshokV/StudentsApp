//
//  taskModel.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 05.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class TaskModel: NSObject {
    // MARK: - Variables
    let coreDataTabelName = String(describing: Tasks.self)
    var TasksDatabaseObject: Tasks?
    var taskDate: CustomDateClass?
    var taskNameShort: String?
    var taskSubject: String?
    var taskPriority: Int?
    var taskDescription: String?
    var taskStatus: Int?
    
    // MARK: - Static getting of tasks
    static func getTasksForToday() -> Array<TaskModel>{
        //Получаем список заданий
        var returnArray: Array<TaskModel> = Array()
        let todayDate = CustomDateClass()
        let tomorrowDate = CustomDateClass()
        tomorrowDate.switchToNextDay()
        var selectionCondition: String = "(status == 0) AND (date >= %@) AND (date <= %@)"
        var predicate:NSPredicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate, tomorrowDate.endOfDay() as NSDate)
        
        var sortDescriptor = NSSortDescriptor(key: #keyPath(Tasks.date), ascending: true)
        
        let fetchRequest:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        //Getting tasks for today and tomorrow
        var searchResults = try! DatabaseController.getContext().fetch(fetchRequest)
        for result in searchResults as [Tasks]{
            returnArray.append(TaskModel(withDatabaseObject: result))
        }
        
        if(returnArray.count >= 6){
            return returnArray
        }
        
        //Getting tasks for day after tomorrow
        selectionCondition = "(status == 0) AND (date >= %@) AND (date <= %@)"
        tomorrowDate.switchToNextDay()
        predicate = NSPredicate(format: selectionCondition,tomorrowDate.startOfDay() as NSDate, tomorrowDate.endOfDay() as NSDate)
        fetchRequest.predicate = predicate
        searchResults = try! DatabaseController.getContext().fetch(fetchRequest)
        for result in searchResults as [Tasks]{
            if(returnArray.count == 6){
               return returnArray
            }
            returnArray.append(TaskModel(withDatabaseObject: result))
        }
        
        //Getting 3 highPriority tasks not in today - day after today e.g. day after after today and grater
        selectionCondition = "(status == 0) AND (date >= %@) AND (priority == 2)"
        tomorrowDate.switchToNextDay()
        predicate = NSPredicate(format: selectionCondition,tomorrowDate.startOfDay() as NSDate)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 3
        searchResults = try! DatabaseController.getContext().fetch(fetchRequest)
        for result in searchResults as [Tasks]{
            if(returnArray.count == 6){
                return returnArray
            }
            returnArray.append(TaskModel(withDatabaseObject: result))
        }
        
        //Getting 3 missed tasks
        selectionCondition = "(status == 0) AND (date < %@)"
        tomorrowDate.switchToNextDay()
        predicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate)
        sortDescriptor = NSSortDescriptor(key: #keyPath(Tasks.priority), ascending: false)
        let secondSortDescriptor = NSSortDescriptor(key: #keyPath(Tasks.date), ascending: true)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 0
        fetchRequest.sortDescriptors = [sortDescriptor, secondSortDescriptor]
        searchResults = try! DatabaseController.getContext().fetch(fetchRequest)
        for result in searchResults as [Tasks]{
            if(returnArray.count == 6){
                return returnArray
            }
            returnArray.append(TaskModel(withDatabaseObject: result))
        }
        

        return returnArray
    }
    
    static func getNumberOfExpiredTasks() -> String {
        let todayDate = CustomDateClass()
        let selectionCondition: String = "(status == 0) AND (date < %@)"
        let predicate:NSPredicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate)
        let fetchRequest:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        fetchRequest.predicate = predicate
        
        //Getting expired tasks
        let searchResults = try! DatabaseController.getContext().fetch(fetchRequest)
        return "\(searchResults.count)"
    }
    
    // MARK:  Groupped Tasks
    static func getTasksGroupedByPriority() -> [[TaskModel]] {
        var returnArray = [[TaskModel]]()
        let fetchRequest:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        let sortDesrt = NSSortDescriptor(key: #keyPath(Tasks.date), ascending: true)
        fetchRequest.sortDescriptors = [sortDesrt]
        
        do{
            let tasks = try DatabaseController.getContext().fetch(fetchRequest)
            var highPriotity = [TaskModel]()
            var midPriotity = [TaskModel]()
            var lowPriotity = [TaskModel]()
            var other = [TaskModel]()
            for task in tasks {
                switch task.priority {
                case 2 :
                    highPriotity.append(TaskModel(withDatabaseObject: task))
                    break
                case 1 :
                    midPriotity.append(TaskModel(withDatabaseObject: task))
                    break
                case 0 :
                    lowPriotity.append(TaskModel(withDatabaseObject: task))
                    break
                default:
                    other.append(TaskModel(withDatabaseObject: task))
                    break
                }
            }
            returnArray.append(highPriotity)
            returnArray.append(midPriotity)
            returnArray.append(lowPriotity)
            returnArray.append(other)
        }catch{
            print("Error getting tasks grouped by priority. \(error.localizedDescription)")
        }
        return returnArray
    }
    
    static func getTasksGroupedByPriority(forDoneTasks: Bool) -> [[TaskModel]] {
        var returnArray = [[TaskModel]]()
        
        let fetchRequest:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        let selectionCondition: String = "(status == \(forDoneTasks))"
        let predicate:NSPredicate = NSPredicate(format: selectionCondition)
        let sortDesrt = NSSortDescriptor(key: #keyPath(Tasks.date), ascending: true)
        fetchRequest.sortDescriptors = [sortDesrt]
        fetchRequest.predicate = predicate
        
        do{
            let tasks = try DatabaseController.getContext().fetch(fetchRequest)
            var highPriotity = [TaskModel]()
            var midPriotity = [TaskModel]()
            var lowPriotity = [TaskModel]()
            var other = [TaskModel]()
            for task in tasks {
                switch task.priority {
                case 2 :
                    highPriotity.append(TaskModel(withDatabaseObject: task))
                    break
                case 1 :
                    midPriotity.append(TaskModel(withDatabaseObject: task))
                    break
                case 0 :
                    lowPriotity.append(TaskModel(withDatabaseObject: task))
                    break
                default:
                    other.append(TaskModel(withDatabaseObject: task))
                    break
                }
            }
            returnArray.append(highPriotity)
            returnArray.append(midPriotity)
            returnArray.append(lowPriotity)
            returnArray.append(other)
        }catch{
            print("Error getting tasks grouped by priority. \(error.localizedDescription)")
        }
        return returnArray
    }
    
    static func getTasksGroupedByDate() -> [[TaskModel]] {
        var returnArray = [[TaskModel]]()
        
        let todayDate = CustomDateClass()
        var selectionCondition: String = "(status == 0) AND (date <= %@)"
        var predicate:NSPredicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Tasks.date), ascending: true)
        
        let fetchRequest:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        //Getting EXPIRED Not done tasks
        let searchResults = try! DatabaseController.getContext().fetch(fetchRequest)
        if(searchResults.count != 0){
            var tmpArray = [TaskModel]()
            for result in searchResults as [Tasks]{
                tmpArray.append(TaskModel(withDatabaseObject: result))
            }
            returnArray.append(tmpArray)
        }
        
        //Getting not expired tasks which is not done
        selectionCondition = "(status == 0) AND (date >= %@)"
        predicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate)
        fetchRequest.predicate = predicate
        
        do{
            let tasks = try DatabaseController.getContext().fetch(fetchRequest)
            //---Creating random date to be able to start the loop
            var dateComponents = DateComponents()
            dateComponents.year = 1975
            var oldDate:Date = Calendar.current.date(from: dateComponents)!
            var tmpArray = [TaskModel]()
            for task in tasks {
                let oder = Calendar.current.compare(task.date!, to: oldDate, toGranularity: .day)
                
                //---Checking if this task has the same date as the last one
                if oder != .orderedSame {
                    if tmpArray.count != 0 {
                        returnArray.append(tmpArray)
                    }
                    tmpArray = [TaskModel]()
                    tmpArray.append(TaskModel(withDatabaseObject: task))
                }
                else{
                    tmpArray.append(TaskModel(withDatabaseObject: task))
                }
                oldDate = task.date!
            }
            if tmpArray.count != 0 {
                returnArray.append(tmpArray)
            }
        }catch{
            print("Error getting tasks grouped by date. \(error.localizedDescription)")
        }
        
        return returnArray
    }
    
    static func getTasksGroupedByDate(forDoneTasks: Bool) -> [[TaskModel]] {
        var returnArray = [[TaskModel]]()
        
        let todayDate = CustomDateClass()
        var selectionCondition: String = "(status == \(forDoneTasks) AND (date <= %@)"
        var predicate:NSPredicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Tasks.date), ascending: true)
        
        let fetchRequest:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        if(!forDoneTasks){
            //Getting EXPIRED tasks
            let searchResults = try! DatabaseController.getContext().fetch(fetchRequest)
            if(searchResults.count != 0){
                var tmpArray = [TaskModel]()
                for result in searchResults as [Tasks]{
                    tmpArray.append(TaskModel(withDatabaseObject: result))
                }
                returnArray.append(tmpArray)
            }
            
            //Getting not expired tasks
            selectionCondition = "(status == \(forDoneTasks))"
            predicate = NSPredicate(format: selectionCondition)
        }else{
            //Getting not expired tasks
            selectionCondition = "(status == \(forDoneTasks)) AND (date >= %@)"
            predicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate)
        }
        
        predicate = NSPredicate(format: selectionCondition,todayDate.startOfDay() as NSDate)
        fetchRequest.predicate = predicate
        
        do{
            let tasks = try DatabaseController.getContext().fetch(fetchRequest)
            //---Creating random date to be able to start the loop
            var dateComponents = DateComponents()
            dateComponents.year = 1975
            var oldDate:Date = Calendar.current.date(from: dateComponents)!
            var tmpArray = [TaskModel]()
            for task in tasks {
                let oder = Calendar.current.compare(task.date!, to: oldDate, toGranularity: .day)
                
                //---Checking if this task has the same date as the last one
                if oder != .orderedSame {
                    if tmpArray.count != 0 {
                        returnArray.append(tmpArray)
                    }
                    tmpArray = [TaskModel]()
                    tmpArray.append(TaskModel(withDatabaseObject: task))
                }
                else{
                    tmpArray.append(TaskModel(withDatabaseObject: task))
                }
                oldDate = task.date!
            }
            if tmpArray.count != 0 {
                returnArray.append(tmpArray)
            }
        }catch{
            print("Error getting tasks grouped by date. \(error.localizedDescription)")
        }
        
        return returnArray
    }
    
    static func getTasksGroupedBySubject() -> [[TaskModel]] {
        var returnArray = [[TaskModel]]()
        
        let fetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        
        do{
            //---Get all subjects... sorted, etc.
            let sortDescr = NSSortDescriptor(key: #keyPath(Subjects.name), ascending: true)
            fetchRequest.sortDescriptors = [sortDescr]
            let subjects = try DatabaseController.getContext().fetch(fetchRequest)
            
            //---fillout the res array
            for subject in subjects {
                var tmpArray: Array<TaskModel> = Array<TaskModel>()
                let tasks = (subject.tasks?.allObjects as! [Tasks]).sorted(by: {$0.date! < $1.date!})
                if tasks.count > 0 {
                    for task in tasks as [Tasks]{
                        tmpArray.append(TaskModel(withDatabaseObject: task))
                    }
                    returnArray.append(tmpArray)
                }
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }
    
    static func getTasksGroupedBySubject(forDoneTasks: Bool) -> [[TaskModel]] {
        var returnArray = [[TaskModel]]()
        
        let selectionCondition: String = "(status == \(forDoneTasks)"
        let predicate:NSPredicate = NSPredicate(format: selectionCondition)
        let fetchRequest:NSFetchRequest<Subjects> = Subjects.fetchRequest()
        fetchRequest.predicate = predicate
        
        do{
            //---Get all subjects... sorted, etc.
            let sortDescr = NSSortDescriptor(key: #keyPath(Subjects.name), ascending: true)
            fetchRequest.sortDescriptors = [sortDescr]
            let subjects = try DatabaseController.getContext().fetch(fetchRequest)
            
            //---fillout the res array
            for subject in subjects {
                var tmpArray: Array<TaskModel> = Array<TaskModel>()
                let tasks = (subject.tasks?.allObjects as! [Tasks]).sorted(by: {$0.date! < $1.date!})
                if tasks.count > 0 {
                    for task in tasks as [Tasks]{
                        tmpArray.append(TaskModel(withDatabaseObject: task))
                    }
                    returnArray.append(tmpArray)
                }
            }
        }
        catch{
            print("Error: \(error)")
        }
        
        return returnArray
    }
    
    // MARK: FetchController Setup
    
    static func setupFetchController() -> NSFetchedResultsController<Tasks>{
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Tasks.date), ascending: false)
        let TasksFetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        TasksFetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchController = NSFetchedResultsController(fetchRequest: TasksFetchRequest, managedObjectContext: DatabaseController.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchController.performFetch()
        return fetchController
    }
    
    // MARK: - Task Update Methods
    func save() -> Bool {
        
        if TasksDatabaseObject == nil {
            return insertTask()
        }else{
            return updateTask()
        }
        
    }
    
    private func insertTask() -> Bool {
        //Добавляем задание в БД
        TasksDatabaseObject = (NSEntityDescription.insertNewObject(forEntityName: coreDataTabelName, into: DatabaseController.getContext()) as! Tasks)
        return updateTask()
    }
    
    private func updateTask() -> Bool {
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
        if TasksDatabaseObject != nil {
            DatabaseController.getContext().delete(TasksDatabaseObject!)
            DatabaseController.saveContext()
            TasksDatabaseObject = nil
            return true
        }
        else{
            return false
        }
        
    }
    
    // MARK: - Help Methods
    override init() {
        super.init()
    }
    
    init(withDatabaseObject: Tasks) {
        super.init()
        
        self.TasksDatabaseObject = withDatabaseObject
        
        self.taskNameShort = TasksDatabaseObject?.shortName != nil ? TasksDatabaseObject?.shortName! : nil;
        self.taskPriority = TasksDatabaseObject?.priority != nil ? Int(TasksDatabaseObject!.priority) : nil;
        self.taskDescription = TasksDatabaseObject?.descrp != nil ? TasksDatabaseObject?.descrp! : nil;
        self.taskStatus = TasksDatabaseObject?.status != nil ? Int(TasksDatabaseObject!.status) : nil;
        self.taskSubject = TasksDatabaseObject?.subject != nil ? TasksDatabaseObject?.subject!.name! : nil;
        self.taskDate = TasksDatabaseObject?.date != nil ? CustomDateClass(withDate: (TasksDatabaseObject?.date)!) : nil;
    }

    //--- Before calling this make sure DB object is not nil, please)
    private func populateEntityWithObjectData() -> Bool {
        TasksDatabaseObject?.shortName = self.taskNameShort
        TasksDatabaseObject?.priority = Int16(self.taskPriority!)
        TasksDatabaseObject?.descrp = self.taskDescription
        TasksDatabaseObject?.status = Int16(self.taskStatus!)
        TasksDatabaseObject?.date = self.taskDate != nil ? self.taskDate?.currentDate : nil;
        
        //--- Handle getting subject as DB object
        if (TasksDatabaseObject?.subject != nil) && (TasksDatabaseObject?.subject?.name == self.taskSubject) {
            //---Well... Do nothing, it is the same subject)...
        }else{
            TasksDatabaseObject?.subject = SubjectModel.getOrCreateSubjectWith(Name: self.taskSubject!)
        }
        
        return true
    }
}
