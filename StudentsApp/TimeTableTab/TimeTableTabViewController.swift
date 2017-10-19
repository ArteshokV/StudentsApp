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
    private var TimeTableCollectionCellIdentifier = "TimeTableCollectionCell"

    @IBOutlet weak var DayLabel: UILabel! //Label для дня недели (понедельник, вторник...)
    @IBOutlet weak var CurrentDayLabel: UILabel! //Label для текущей даты просмотра
    @IBOutlet weak var PreviousWeekButton: UIButton! //кнопка перехода на предыдущую неделю
    @IBOutlet weak var BeginOfWeekLabel: UILabel! //Label для начала недели
    @IBOutlet weak var EndOfWeekLabel: UILabel! //Label для конца недели
    @IBOutlet weak var WeekNumberLabel: UILabel! //Label для номера недели
    @IBOutlet weak var NextWeekButton: UIButton! //кнопка перехода на следующую неделю
    @IBOutlet weak var CollectionOfTables: UICollectionView!
    
    
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
        ShowDates(CurrentDate: TodayDate!)
        CollectionOfTables.scrollToItem(at: IndexPath(item: GetDayNumberFromDate(Date: TodayDate!), section: 0), at: .centeredHorizontally, animated: false)
    }
    
    
    // нажатие кнопки перехода на следующую неделю
    @IBAction func SwapNextWeek(_ sender: Any) {
        TodayDate?.switchToNextWeek()
        CurrentTimeTable  = []
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        ShowDates(CurrentDate: TodayDate!)
        CollectionOfTables.scrollToItem(at: IndexPath(item: GetDayNumberFromDate(Date: TodayDate!), section: 0), at: .centeredHorizontally, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TodayDate = CustomDateClass()
        CollectionOfTables.register(UINib(nibName: "TimeTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TimeTableCollectionCellIdentifier)
        CollectionOfTables.scrollToItem(at: IndexPath(item: GetDayNumberFromDate(Date: TodayDate!), section: 0), at: .centeredHorizontally, animated: false)
        
        ShowDates(CurrentDate: TodayDate!)
        //получаем расписание на текущий день
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func GetDateFromDayNumberInSemester (DayNumber: Int) -> CustomDateClass {
        let beginOfSemester = CustomDateClass(withString: "01.09.2017")
        let DateForDay = CustomDateClass.init(withDate: (beginOfSemester.currentDate?.addingTimeInterval(TimeInterval(60*60*24*DayNumber)))!)
        return DateForDay
    }
    
    func GetDayNumberFromDate (Date: CustomDateClass) -> Int {
        let beginOfSemester = CustomDateClass(withString: "01.09.2017")
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.day], from: beginOfSemester.currentDate!, to: Date.currentDate!)
        let NumberOfDay = comp.day!
        return NumberOfDay
    }
}



extension TimeTableTabViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        TodayDate = GetDateFromDayNumberInSemester(DayNumber: CollectionOfTables.indexPathsForVisibleItems[0][1])
        ShowDates(CurrentDate: TodayDate!)
    }
}

extension TimeTableTabViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let beginOfSemester = CustomDateClass(withString: "01.09.2017")
        let endOfSemester = CustomDateClass(withString: "24.12.2017")
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.day], from: beginOfSemester.currentDate!, to: endOfSemester.currentDate!)
        let NumberOfDaysInSemester = comp.day!
        return NumberOfDaysInSemester
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTableCollectionCellIdentifier, for: indexPath as IndexPath) as! TimeTableCollectionViewCell
        cell.CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (GetDateFromDayNumberInSemester(DayNumber: indexPath.item).stringFromDate())))
        cell.TodayDate = GetDateFromDayNumberInSemester(DayNumber: indexPath.item)
        cell.TableForClasses.reloadData()
        return cell
    }
    
}

extension TimeTableTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Вычисляем размер ячейки
        
        return CGSize(width: CollectionOfTables.frame.size.width, height: CollectionOfTables.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
