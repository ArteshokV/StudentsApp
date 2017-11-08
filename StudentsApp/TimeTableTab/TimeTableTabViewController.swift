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
    private var DateOfBeginOfSemester = CustomDateClass(withString: "01.09.2017")//дата начала семестра
    private var DateOfEndOfSemester = CustomDateClass(withString: "24.12.2017")//дата конца семестра
    private var blurEffectView: UIVisualEffectView?
    
    let appDesign = CustomApplicationLook()
    
    @IBOutlet weak var DayLabel: UILabel! //Label для дня недели (понедельник, вторник...)
    @IBOutlet weak var CurrentDayLabel: UILabel! //Label для текущей даты просмотра
    @IBOutlet weak var PreviousWeekButton: UIButton! //кнопка перехода на предыдущую неделю
    @IBOutlet weak var BeginOfWeekLabel: UILabel! //Label для начала недели
    @IBOutlet weak var EndOfWeekLabel: UILabel! //Label для конца недели
    @IBOutlet weak var WeekNumberLabel: UILabel! //Label для номера недели
    @IBOutlet weak var NextWeekButton: UIButton! //кнопка перехода на следующую неделю
    @IBOutlet weak var TickLabel: UILabel!
    @IBOutlet weak var CollectionOfTables: UICollectionView!//коллекция таблиц
    
    
    //функция отображения параметров в Label'ы
    func ShowDates (CurrentDate: CustomDateClass) {
        DayLabel.text = TodayDate?.weekDayString()
        CurrentDayLabel.text = TodayDate?.stringFromDate()
        EndOfWeekLabel.text = TodayDate?.weekEndString()
        BeginOfWeekLabel.text = TodayDate?.weekBeginSting()
        WeekNumberLabel.text = "\(TodayDate!.weekNumber(fromStartDate: "01.09.2017")) неделя"
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        CollectionOfTables.scrollToItem(at: IndexPath(item: GetDayNumberFromDate(Date: TodayDate!), section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TodayDate = CustomDateClass()
        CollectionOfTables.register(UINib(nibName: "TimeTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TimeTableCollectionCellIdentifier)
        CollectionOfTables.translatesAutoresizingMaskIntoConstraints = false
        CollectionOfTables.clipsToBounds = true
        CollectionOfTables.autoresizesSubviews = true

        CollectionOfTables.scrollToItem(at: IndexPath(item: GetDayNumberFromDate(Date: TodayDate!), section: 0), at: .centeredHorizontally, animated: false)
        ShowDates(CurrentDate: TodayDate!)
        
        appDesign.initBackground(ofView: self.view)
        
        CollectionOfTables.backgroundColor = UIColor.clear
        
        appDesign.managedMainLablesContext.append(DayLabel)
        DayLabel.textColor = appDesign.mainTextColor
        appDesign.managedMainLablesContext.append(TickLabel)
        TickLabel.textColor = appDesign.mainTextColor
        appDesign.managedMainLablesContext.append(CurrentDayLabel)
        CurrentDayLabel.textColor = appDesign.mainTextColor
        appDesign.managedMainLablesContext.append(BeginOfWeekLabel)
        BeginOfWeekLabel.textColor = appDesign.mainTextColor
        appDesign.managedMainButonsContext.append(PreviousWeekButton)
        PreviousWeekButton.setTitleColor(appDesign.mainTextColor, for: .normal)
        appDesign.managedMainLablesContext.append(EndOfWeekLabel)
        EndOfWeekLabel.textColor = appDesign.mainTextColor
        appDesign.managedMainLablesContext.append(WeekNumberLabel)
        WeekNumberLabel.textColor = appDesign.mainTextColor
        appDesign.managedMainButonsContext.append(NextWeekButton)
        NextWeekButton.setTitleColor(appDesign.mainTextColor, for: .normal)
        
        
        //constraints and other parametrs
        DayLabel.adjustsFontSizeToFitWidth = true
        DayLabel.adjustsFontForContentSizeCategory = true
        DayLabel.minimumScaleFactor = 0.2
        DayLabel.numberOfLines = 0
        
        CurrentDayLabel.adjustsFontSizeToFitWidth = true
        CurrentDayLabel.adjustsFontForContentSizeCategory = true
        CurrentDayLabel.minimumScaleFactor = 0.2
        CurrentDayLabel.numberOfLines = 0
        
        BeginOfWeekLabel.adjustsFontSizeToFitWidth = true
        BeginOfWeekLabel.adjustsFontForContentSizeCategory = true
        BeginOfWeekLabel.minimumScaleFactor = 0.2
        BeginOfWeekLabel.numberOfLines = 1
        
        EndOfWeekLabel.adjustsFontSizeToFitWidth = true
        EndOfWeekLabel.adjustsFontForContentSizeCategory = true
        EndOfWeekLabel.minimumScaleFactor = 0.2
        EndOfWeekLabel.numberOfLines = 1
        
        WeekNumberLabel.adjustsFontSizeToFitWidth = true
        WeekNumberLabel.adjustsFontForContentSizeCategory = true
        WeekNumberLabel.minimumScaleFactor = 0.2
        WeekNumberLabel.numberOfLines = 1
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Получение даты по номеру дня в семестре
    func GetDateFromDayNumberInSemester (DayNumber: Int) -> CustomDateClass {
        let DateForDay = CustomDateClass.init(withDate: (DateOfBeginOfSemester .currentDate?.addingTimeInterval(TimeInterval(60*60*24*DayNumber)))!)
        return DateForDay
    }
    
    //Получение номера дня в семестре по дате
    func GetDayNumberFromDate (Date: CustomDateClass) -> Int {
        let calendar = Calendar.current
        let DateComponent = calendar.dateComponents([.day], from: DateOfBeginOfSemester .currentDate!, to: Date.currentDate!)
        let NumberOfDay = DateComponent.day!
        return NumberOfDay
    }
}



extension TimeTableTabViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        TodayDate = GetDateFromDayNumberInSemester(DayNumber: CollectionOfTables.indexPathsForVisibleItems[0][1])
        ShowDates(CurrentDate: TodayDate!)
        
        let visibleCell = CollectionOfTables.cellForItem(at: CollectionOfTables.indexPathsForVisibleItems[0]) as! TimeTableCollectionViewCell
        if(visibleCell.CurrentTimeTable.count != 0){
            visibleCell.TableForClasses.scrollToRow(at: IndexPath(row: 0, section:0), at: .top, animated: true)
        }
    }
}

extension TimeTableTabViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let calendar = Calendar.current
        let DateComponent = calendar.dateComponents([.day], from: DateOfBeginOfSemester.currentDate!, to: DateOfEndOfSemester.currentDate!)
        let NumberOfDaysInSemester = DateComponent.day!
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
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height) //Вычисляем размер ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }

}
