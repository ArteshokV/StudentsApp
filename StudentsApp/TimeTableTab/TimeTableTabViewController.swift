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
    
    @IBOutlet weak var DayLabel: UILabel! //Label для дня недели (понедельник, вторник...)
    @IBOutlet weak var CurrentDayLabel: UILabel! //Label для текущей даты просмотра
    @IBOutlet weak var PreviousWeekButton: UIButton! //кнопка перехода на предыдущую неделю
    @IBOutlet weak var BeginOfWeekLabel: UILabel! //Label для начала недели
    @IBOutlet weak var EndOfWeekLabel: UILabel! //Label для конца недели
    @IBOutlet weak var WeekNumberLabel: UILabel! //Label для номера недели
    @IBOutlet weak var NextWeekButton: UIButton! //кнопка перехода на следующую неделю
    @IBOutlet weak var CollectionOfTables: UICollectionView!//коллекция таблиц
    
    
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
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackGroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView!, at: 1)
        
        CollectionOfTables.backgroundColor = UIColor.clear
        
        DayLabel.textColor = UIColor.white
        CurrentDayLabel.textColor = UIColor.white
        PreviousWeekButton.setTitleColor(UIColor.white, for: .normal)
        BeginOfWeekLabel.textColor = UIColor.white
        EndOfWeekLabel.textColor = UIColor.white
        WeekNumberLabel.textColor = UIColor.white
        NextWeekButton.setTitleColor(UIColor.white, for: .normal)
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
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120) //Вычисляем размер ячейки
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
