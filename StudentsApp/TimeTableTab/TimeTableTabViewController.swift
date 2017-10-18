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
        ShowDates(CurrentDate: TodayDate!)
    }
    
    
    // нажатие кнопки перехода на следующую неделю
    @IBAction func SwapNextWeek(_ sender: Any) {
        TodayDate?.switchToNextWeek()
        CurrentTimeTable  = []
        CurrentTimeTable = TimetableModel.getTimetable(Date: CustomDateClass(withString: (TodayDate?.stringFromDate())!))
        ShowDates(CurrentDate: TodayDate!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionOfTables.register(UINib(nibName: "TimeTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TimeTableCollectionCellIdentifier)
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



extension TimeTableTabViewController: UICollectionViewDelegate {
    
}

extension TimeTableTabViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTableCollectionCellIdentifier, for: indexPath as IndexPath) as! TimeTableCollectionViewCell
        cell.CurrentTimeTable = CurrentTimeTable
        cell.TodayDate = TodayDate
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
