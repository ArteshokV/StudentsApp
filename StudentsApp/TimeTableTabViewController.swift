//
//  TimeTableTabViewController.swift
//  StudentsApp
//
//  Created by AgentSamogon on 09.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TimeTableTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var TodayDate = Date() // Переменная для текущей даты
    private var WeekBeginDate = Date() // Переменная для даты начала недели
    private var WeekEndDate = Date() // Переменная для даты конца недели
    private var dateFormatter = DateFormatter() // объект для форматирования вывода даты
    private var GregorianCalendar : NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! // переменная календаря
    private var TodatDateString = String () // строка текущей даты
    private var WeekBeginString = String () //строка даты начала недели
    private var WeekEndString = String () //строка даты конца недели
    private var WeekdayComponent = NSDateComponents() // объект для определения дня недели
    private var SemesterBeginDate = Date () // дата начала семестра
    private var SemesterBeginString: String = "01.09.2017" // строка начала семестра
    private var NumberOfWeek: Int = 1 //счетчик недель
    private var CurrentTimeTable: Array<TimetableModel> = Array() //массив занятий в расписании текущего дня
    
    private var swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]


    @IBOutlet weak var DayLabel: UILabel! //Label для дня недели (понедельник, вторник...)
    @IBOutlet weak var CurrentDayLabel: UILabel! //Label для текущей даты просмотра
    @IBOutlet weak var PreviousWeekButton: UIButton! //кнопка перехода на предыдущую неделю
    @IBOutlet weak var BeginOfWeekLabel: UILabel! //Label для начала недели
    @IBOutlet weak var EndOfWeekLabel: UILabel! //Label для конца недели
    @IBOutlet weak var WeekNumberLabel: UILabel! //Label для номера недели
    @IBOutlet weak var NextWeekButton: UIButton! //кнопка перехода на следующую неделю
    @IBOutlet weak var TimeTableView: UITableView! //таблица отображения расписания
    
    
    // функция получения номера текущего дня в неделе
    func GetTodayDayNumber (CurrentDate: Date) -> Int {
        WeekdayComponent = GregorianCalendar.components(.weekday, from: CurrentDate as Date) as NSDateComponents
        let BackInt = WeekdayComponent.weekday - 2
        return BackInt
    }
    
    // функция определения номера недели
    func GetWeekNumber (CurrentDate: Date) -> Int {
        NumberOfWeek = 1
        
        let DaysToBegin = GetTodayDayNumber(CurrentDate: CurrentDate)
        let fDate = CurrentDate.addingTimeInterval(TimeInterval(-60*60*24*DaysToBegin))
        SemesterBeginDate = dateFormatter.date(from: SemesterBeginString)!
        while SemesterBeginDate < fDate {
            NumberOfWeek = NumberOfWeek + 1
            SemesterBeginDate = SemesterBeginDate.addingTimeInterval(60*60*24*7)
        }
        return NumberOfWeek
    }
    
    // функция формата даты из "October 1, 2017" -> "1 October"
    func MyDateFormatt (Date: String) -> String {
        /*let CutNumber = Date.index(of: ",")
        let CutDate = String(Date.prefix(upTo: CutNumber!))
        let SpaceNumber = CutDate.index(of: " ")
        let Month = String(CutDate.prefix(upTo: SpaceNumber!))
        let Day = String((CutDate.suffix(from: SpaceNumber!)).dropFirst())
        let FinalDate = Day + " " + Month*/
        return Date
    }
    
    //функция определения названия текущего дня
    func GetCurrentDay (CurrentDate: Date) -> String {
        let numberOfDay = GetTodayDayNumber(CurrentDate: CurrentDate)
        let arrayOfDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let currentDay = arrayOfDays[numberOfDay]
        return currentDay
    }
    
    //функция отображения параметров в Label'ы
    func ShowDates (CurrentDate: Date) {
        TodatDateString = dateFormatter.string(from: TodayDate)
        CurrentDayLabel.text = MyDateFormatt(Date: TodatDateString)
        let DaysToBegin = GetTodayDayNumber(CurrentDate: TodayDate)
        WeekBeginDate = TodayDate.addingTimeInterval(TimeInterval(-60*60*24*DaysToBegin))
        WeekBeginString = dateFormatter.string(from: WeekBeginDate)
        WeekEndDate = WeekBeginDate.addingTimeInterval(60*60*24*6)
        WeekEndString = dateFormatter.string(from: WeekEndDate)
        EndOfWeekLabel.text = MyDateFormatt(Date:WeekEndString)
        BeginOfWeekLabel.text = MyDateFormatt(Date:WeekBeginString)
        WeekNumberLabel.text = String(GetWeekNumber(CurrentDate: TodayDate))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftBlogs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdentCell", for: indexPath)
        
        let row = indexPath.row
        
        
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // нажатие кнопки перехода на предыдущую неделю
    @IBAction func SwapPreviousWeek(_ sender: Any) {
        TodayDate = TodayDate.addingTimeInterval(-60*60*24*7)
        ShowDates(CurrentDate: TodayDate)
    }
    
    
    // нажатие кнопки перехода на следующую неделю
    @IBAction func SwapNextWeek(_ sender: Any) {
        TodayDate = TodayDate.addingTimeInterval(60*60*24*7)
        ShowDates(CurrentDate: TodayDate)
    }
    
    
    override func viewDidLoad() {
        TimeTableView.delegate = self
        TimeTableView.dataSource = self
        
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        DayLabel.text = GetCurrentDay(CurrentDate: TodayDate)
        ShowDates(CurrentDate: TodayDate)
        //получаем расписание на текущий день
        CurrentTimeTable = TimetableModel.getTimetable(Date:(dateFormatter.string(from: TodayDate)))
        
        
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
