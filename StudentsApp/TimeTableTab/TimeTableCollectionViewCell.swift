//
//  TimeTableCollectionViewCell.swift
//  StudentsApp
//
//  Created by AgentSamogon on 18.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TimeTableCollectionViewCell: UICollectionViewCell {

    var CurrentTimeTable: [TimetableModel]!//массив занятий в расписании текущего дня
    var TodayDate: CustomDateClass?
    private var TimetableCellIdentifier = "TimeTableCell"
    
    @IBOutlet weak var TableForClasses: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TableForClasses.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
    }

}

extension TimeTableCollectionViewCell: UITableViewDataSource {
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

extension TimeTableCollectionViewCell: UITableViewDelegate {
    
}
