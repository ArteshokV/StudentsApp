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
        TableForClasses.separatorColor = UIColor.clear
        TableForClasses.showsVerticalScrollIndicator = false
        
        TableForClasses.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[subview]-10-|",
            options: [],
            metrics: nil,
            views: ["subview":TableForClasses]))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[subview]-0-|",
            options: [],
            metrics: nil,
            views: ["subview":TableForClasses]))
        
        /*
        TableForClasses.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: TableForClasses, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: TableForClasses, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: TableForClasses, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: TableForClasses, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        TableForClasses.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
 */
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //TableForClasses.frame = frame
        //TableForClasses.reloadData()
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
