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
        TableForClasses.backgroundColor = UIColor.clear
        TableForClasses.scrollsToTop = true
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: ((TodayDate?.weekDayString())! + " " + (TodayDate?.stringFromDate())!), aligment: .center, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.getViewForFooterInSectionWithLabel(tableView: tableView)
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  50
    }
}

extension TimeTableCollectionViewCell: UITableViewDelegate {
    
}
