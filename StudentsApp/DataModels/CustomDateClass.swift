//
//  CustomDateClass.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 10.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class CustomDateClass: NSObject {
    
    // MARK: - Variables
    var currentDate: Date?
    var dayInt: Int?
    var monthInt: Int?
    var yearInt: Int?
    var weekDayInt: Int?
    
    private var numberOfSecondsIn24Hours = 60*60*24
    private var monthsNamesInString = ["Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"]
    private var weekDaysNamesInString = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    // MARK: - FormattedStringOut
    func stringFromDate() -> String {
        return "\(dayInt!).\(monthInt!).\(yearInt!)"
    }
    
    func weekBeginSting() -> String {
        let timeInterval = TimeInterval(-numberOfSecondsIn24Hours*(weekDayInt!-1))
        let tempDate = currentDate?.addingTimeInterval(timeInterval)
        
        let calendar = Calendar.current
        
        let tempMonth = calendar.component(.month, from: tempDate!)
        let tempDay = calendar.component(.day, from: tempDate!)
        
        return "\(tempDay) \(monthsNamesInString[tempMonth-1])"
    }
    
    func weekEndString() -> String {
        let timeInterval = TimeInterval(+numberOfSecondsIn24Hours*(7-weekDayInt!))
        let tempDate = currentDate?.addingTimeInterval(timeInterval)
        
        let calendar = Calendar.current
        
        let tempMonth = calendar.component(.month, from: tempDate!)
        let tempDay = calendar.component(.day, from: tempDate!)
        
        return "\(tempDay) \(monthsNamesInString[tempMonth-1])"
    }
    
    func weekDayString() -> String {
        return "\(weekDaysNamesInString[weekDayInt!-1])"
    }
    
    func todayStringWithoutWeekDay() -> String {
        return "\(dayInt!) \(monthsNamesInString[monthInt!-1])"
    }
    
    func todayString() -> String {
        return "\(weekDaysNamesInString[weekDayInt!-1]) \n\(dayInt!) \(monthsNamesInString[monthInt!-1])"
    }
    
    func weekNumber(fromStartDate: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let tempDate = dateFormatter.date(from: fromStartDate)!
        
        let calendar = Calendar.current
        let tempWeekDayInt = calendar.component(.weekday, from: tempDate) - 1
        
        let timeIntervalToMonday = TimeInterval(-numberOfSecondsIn24Hours*tempWeekDayInt)
        let tempDateStart = tempDate.addingTimeInterval(timeIntervalToMonday)
        
        let timeInterval = TimeInterval(-numberOfSecondsIn24Hours*weekDayInt!)
        let tempDateEnd = currentDate?.addingTimeInterval(timeInterval)
        
        return Int((tempDateEnd?.timeIntervalSince(tempDateStart))!/Double(numberOfSecondsIn24Hours)/7)+1
    }
    
    func startOfDay() -> String{
        return "\(yearInt!)-\(monthInt!)-\(dayInt!) 00:00"
    }
    func endOfDay() -> String{
        return "\(yearInt!)-\(monthInt!)-\(dayInt!) 23:59"
    }
    
    // MARK: - Switchers to other days
    func switchToNextWeek() {
        let timeInterval = TimeInterval(numberOfSecondsIn24Hours*7)
        currentDate = currentDate?.addingTimeInterval(timeInterval)
        
        self.updateClassProperties()
    }
    
    func switchToPreviousWeek() {
        let timeInterval = TimeInterval(-numberOfSecondsIn24Hours*7)
        currentDate = currentDate?.addingTimeInterval(timeInterval)
        
        self.updateClassProperties()
    }
    
    func switchToPreviousDay() {
        let timeInterval = TimeInterval(-numberOfSecondsIn24Hours)
        currentDate = currentDate?.addingTimeInterval(timeInterval)
        
        self.updateClassProperties()
    }
    
    func switchToNextDay() {
        let timeInterval = TimeInterval(numberOfSecondsIn24Hours)
        currentDate = currentDate?.addingTimeInterval(timeInterval)
        
        self.updateClassProperties()
    }
    
    // MARK: - Initialisers
    override init() {
        super.init()
        currentDate = Date()
        
        self.updateClassProperties()
    }
    
    init(withString: String) {
        super.init()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        currentDate = dateFormatter.date(from: withString)!
        
        self.updateClassProperties()
    }
    
    init(withday: Int, month: Int, year: Int) {
        super.init()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        currentDate = dateFormatter.date(from: "\(withday).\(month).\(year)")!
        
        self.updateClassProperties()
    }
    
    init(withDate: Date) {
        super.init()
        currentDate = withDate
        
        self.updateClassProperties()
    }
    
    // MARK: - Private functions
    private func updateClassProperties(){
        let calendar = Calendar.current
        
        yearInt =  calendar.component(.year, from: currentDate!)
        monthInt = calendar.component(.month, from: currentDate!)
        dayInt = calendar.component(.day, from: currentDate!)
        weekDayInt = calendar.component(.weekday, from: currentDate!) - 1
        if weekDayInt == 0
        {
            weekDayInt = 7
        }
    }
    
    // MARK: - Static functions
    static func todaysDateString() -> String{
        let todayDate = Date()
        let calendar = Calendar.current
        
        let tempMonthInt = calendar.component(.month, from: todayDate)
        let tempDayInt = calendar.component(.day, from: todayDate)
        var tempWeekDayInt = calendar.component(.weekday, from: todayDate) - 1
        if tempWeekDayInt == 0 {
            tempWeekDayInt = 7
        }
        
        let tempMonthsNamesInString = ["Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"]
        let tempWeekDaysNamesInString = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
        
        return "\(tempWeekDaysNamesInString[tempWeekDayInt-1]) \n\(tempDayInt) \(tempMonthsNamesInString[tempMonthInt-1])"
    }
    
    /*func printProperties(){
        //print(self.dayInt!)
        //print(self.monthInt!)
        //print(self.yearInt!)
        //print(self.weekDayInt!)
        //print(self.weekDayString())
        //print(self.todayStringWithoutWeekDay())
        //print(self.stringFromDate())
        //print(self.todayString())
        //print(self.weekBeginSting())
        //print(self.weekEndString())
        //print(self.weekNumber(fromStartDate: "01.09.2017"))
        
    }*/
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? CustomDateClass else {return false}
        return (self.dayInt! == obj.dayInt!)&&(self.monthInt! == obj.monthInt!)&&(self.yearInt! == obj.yearInt!)
    }
    
}


// MARK: - Compare functions

     func > (left: CustomDateClass, right: CustomDateClass) -> Bool {
        if(left.currentDate! > right.currentDate!){
            return true
        }else{
            return false
        }
    }

    func < (left: CustomDateClass, right: CustomDateClass) -> Bool {
        if(left.currentDate! < right.currentDate!){
            return true
        }else{
            return false
        }
    }

     func <= (left: CustomDateClass, right: CustomDateClass) -> Bool {
        if(left.currentDate! < right.currentDate!)||(left.isEqual(right)){
            return true
        }else{
            return false
        }
    }

     func >=(left: CustomDateClass, right: CustomDateClass) -> Bool {
        print("GRATER THAN")
        if(left.currentDate! > right.currentDate!)||(left.isEqual(right)){
            return true
        }else{
            return false
        }
    }
