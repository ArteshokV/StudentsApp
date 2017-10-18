//
//  TodayTimetableTableViewCell.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 17.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TodayTimetableTableViewCell: UITableViewCell {

    var TodayTimeTableArray: [TimetableModel]!
    var TomorrowTimeTableArray: [TimetableModel]!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var TodayTable: UITableView!
    @IBOutlet weak var TomorrowTable: UITableView!
    let TimetableCellIdentifier = "TimetableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ScrollView.delegate = self
        
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TodayTable.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
        TomorrowTable.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
        TodayTable.delegate = self
        TodayTable.dataSource = self
        TomorrowTable.delegate = self
        TomorrowTable.dataSource = self
        
        //Полуение массива предметов
        let cust = CustomDateClass(withString: "19.10.2017")
        TodayTimeTableArray = TimetableModel.getTimetable(Date: cust)
        cust.switchToNextDay()
        TomorrowTimeTableArray = TimetableModel.getTimetable(Date: cust)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.layoutIfNeeded()
        ScrollView.layoutIfNeeded()
        //ScrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        
        ScrollView.contentSize = CGSize(width:ScrollView.frame.width*2, height:ScrollView.frame.height)
        //ScrollView.contentSize.width = ScrollView.contentSize.width*2
        let width = ScrollView.frame.width
        let height = ScrollView.frame.height
        TodayTable.frame = CGRect(x: 0, y: 0, width: width, height: height)
        TomorrowTable.frame = CGRect(x: width, y: 0, width: width, height: height)
        //TodayTable.backgroundColor = UIColor.red
        //TomorrowTable.backgroundColor = UIColor.blue
        //TodayTable.layoutIfNeeded()
        //TomorrowTable.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - UIScrollViewDelegate protocol
extension TodayTimetableTableViewCell: UIScrollViewDelegate{
    
}


// MARK: - UITableViewDelegate protocol
extension TodayTimetableTableViewCell: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - UITableViewDataSource protocol
extension TodayTimetableTableViewCell: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == TodayTable){
            return TodayTimeTableArray.count
        }else{
            return TomorrowTimeTableArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TODAY"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TimetableCellIdentifier, for: indexPath) as! TimetableTableViewCell
        
        let model = tableView == TodayTable ? TodayTimeTableArray[indexPath.item] : TomorrowTimeTableArray[indexPath.item]
        
        cell.initWithTimetable(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //print("PrepareHeaderFunction")
        let sectionView = UIView()
        sectionView.backgroundColor = UIColor.clear
        
        let sectionHeaderLabel = UILabel()
        
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        //sectionHeaderLabel.backgroundColor = UIColor.init(red: 100, green: 0, blue: 0, alpha: 0.5)
        if(section == 0){
            sectionHeaderLabel.text = "Сегодня"
        }else{
            sectionHeaderLabel.text = "Задания"
        }
        sectionHeaderLabel.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:50)
        sectionView.addSubview(sectionHeaderLabel)
        return sectionView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
