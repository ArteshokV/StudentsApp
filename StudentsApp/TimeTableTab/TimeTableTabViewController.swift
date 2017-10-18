//
//  TimeTableTabViewController.swift
//  StudentsApp
//
//  Created by AgentSamogon on 09.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TimeTableTabViewController: UIViewController {
    
    
    private var CurrentTimeTable: [TimetableModel]!//массив занятий в расписании текущего дня
    private var TodayDate: CustomDateClass?
    private var TimetableCellIdentifier = "IdentCell"

    @IBOutlet weak var DayLabel: UILabel! //Label для дня недели (понедельник, вторник...)
    @IBOutlet weak var CurrentDayLabel: UILabel! //Label для текущей даты просмотра
    @IBOutlet weak var PreviousWeekButton: UIButton! //кнопка перехода на предыдущую неделю
    @IBOutlet weak var BeginOfWeekLabel: UILabel! //Label для начала недели
    @IBOutlet weak var EndOfWeekLabel: UILabel! //Label для конца недели
    @IBOutlet weak var WeekNumberLabel: UILabel! //Label для номера недели
    @IBOutlet weak var NextWeekButton: UIButton! //кнопка перехода на следующую неделю

    @IBOutlet weak var TimeTableView: UITableView! //таблица отображения расписания
    
    @IBOutlet var RightSwipe: UISwipeGestureRecognizer!
    @IBOutlet var LeftSwipe: UISwipeGestureRecognizer!
    //функция отображения параметров в Label'ы
    func ShowDates (CurrentDate: CustomDateClass) {
        DayLabel.text = TodayDate?.weekDayString()
        CurrentDayLabel.text = TodayDate?.stringFromDate()
        EndOfWeekLabel.text = TodayDate?.weekEndString()
        BeginOfWeekLabel.text = TodayDate?.weekBeginSting()
        WeekNumberLabel.text = "\(TodayDate!.weekNumber(fromStartDate: "01.09.2017"))"
    }

    
    // нажатие кнопки перехода на предыдущую неделю
    @IBAction func SwapPreviousWeek(_ sender: Any) {
        TodayDate?.switchToPreviousWeek()
        CurrentTimeTable  = []
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        TimeTableView.reloadData()
        ShowDates(CurrentDate: TodayDate!)
    }
    
    
    // нажатие кнопки перехода на следующую неделю
    @IBAction func SwapNextWeek(_ sender: Any) {
        TodayDate?.switchToNextWeek()
        CurrentTimeTable  = []
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        TimeTableView.reloadData()
        ShowDates(CurrentDate: TodayDate!)
    }
    
    @IBAction func SwipeOnRight(_ sender: Any) {
        TodayDate?.switchToPreviousDay()
        CurrentTimeTable  = []
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        TimeTableView.reloadData()
        ShowDates(CurrentDate: TodayDate!)
    }
    
    @IBAction func SwipeOnLeft(_ sender: Any) {
        TodayDate?.switchToNextDay()
        CurrentTimeTable  = []
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        TimeTableView.reloadData()
        ShowDates(CurrentDate: TodayDate!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimeTableView.rowHeight = UITableViewAutomaticDimension
        TimeTableView.estimatedRowHeight = 120
        TimeTableView.autoresizesSubviews = true
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TimeTableView.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
        
        TodayDate = CustomDateClass()
        ShowDates(CurrentDate: TodayDate!)
        //получаем расписание на текущий день
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension TimeTableTabViewController: UITableViewDelegate {
    
}

extension TimeTableTabViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Получим количество строк для конкретной секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentTimeTable.count
    }
    
    // Получим заголовок для секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = (TodayDate?.weekDayString())! + " " + (TodayDate?.stringFromDate())!
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    
    // Получим данные для использования в ячейке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimetableCellIdentifier, for: indexPath) as! TimetableTableViewCell
        
        cell.initWithTimetable(model: CurrentTimeTable[indexPath.item])
        
        return cell
    }
}
