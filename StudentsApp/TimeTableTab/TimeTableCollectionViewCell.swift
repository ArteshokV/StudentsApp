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
    let appDesign = CustomApplicationLook()
    private var TimetableCellIdentifier = "TimeTableCell"
    let EmptyCellIdentifier = "EmptyCell"
    
    @IBOutlet weak var TableForClasses: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TableForClasses.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
        TableForClasses.register(UITableViewCell.self, forCellReuseIdentifier: EmptyCellIdentifier)
        
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
        return CurrentTimeTable.count != 0 ? CurrentTimeTable.count : 1
    }
    
    // Получим заголовок для секции
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.initHeader(withWidth: tableView.frame.width, andMainText: ((TodayDate?.weekDayString())! + " " + (TodayDate?.stringFromDate())!))
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.initFooter(withWidth: tableView.frame.width)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    
    
    // Получим данные для использования в ячейке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(CurrentTimeTable.count != 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: TimetableCellIdentifier, for: indexPath) as! TimetableTableViewCell
            cell.initWithTimetable(model: CurrentTimeTable[indexPath.item])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCellIdentifier, for: indexPath)
            cell.backgroundColor = appDesign.underLayerColor
            appDesign.managedLayersContext.append(cell)
            
            cell.textLabel?.text = "У вас нет пар!"
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = appDesign.mainTextColor
            appDesign.managedMainLablesContext.append(cell.textLabel!)
            
            let sepLine = UIView()
            let square = CGRect(
                origin: CGPoint(x: 15, y: 1),
                size: CGSize(width: tableView.frame.width - 30, height: 0.5))
            
            sepLine.frame = square
            sepLine.layer.borderWidth = 0.5
            sepLine.layer.borderColor = UIColor.lightGray.cgColor
            cell.addSubview(sepLine)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  50
    }
}

extension TimeTableCollectionViewCell: UITableViewDelegate {
    
}
