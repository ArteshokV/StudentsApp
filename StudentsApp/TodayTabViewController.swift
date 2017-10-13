//
//  TodayTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 10.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TodayTabViewController: UIViewController {

    @IBOutlet weak var TodayDateLabel: UILabel!
    @IBOutlet weak var ProgressViewOutlet: UIProgressView!
    @IBOutlet weak var TableViewOutlet: UITableView!
    
    let TimetableCellIdentifier = "TimetableCell"
    let TasksCellIdentifier = "TaskCell"
    
    var timeTableArray: [TimetableModel]! //Добавляем пустой массив расписания
    var tasksArray: [TaskModel]! //Добавляем пустой массив заданий
    
    var chosenObject = 0
    //
    var date1: CustomDateClass?
    var date2: CustomDateClass?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date1 = CustomDateClass()
        //self.prefersStatusBarHidden = true
        
        TableViewOutlet.rowHeight = UITableViewAutomaticDimension
        TableViewOutlet.estimatedRowHeight = 120
        TableViewOutlet.autoresizesSubviews = true
        
        
        
        //Получение сегодняшней даты
        TodayDateLabel.text = CustomDateClass.todaysDateString()
        
        //Полуение массива предметов
        let cust = CustomDateClass(withString: "12.10.2017")
        timeTableArray = TimetableModel.getTimetable(Date: cust)
        tasksArray = TaskModel.getTasks()

        ProgressViewOutlet.transform = ProgressViewOutlet.transform.scaledBy(x: 1, y: 10)

        // Do any additional setup after loading the view.
        let taskCellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        TableViewOutlet.register(taskCellNib, forCellReuseIdentifier: TasksCellIdentifier)
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TableViewOutlet.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromTodayToTasksView"){
            let taskVC = segue.destination as! TaskViewEditViewController
            taskVC.taskModelObject = tasksArray[chosenObject]
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDelegate protocol
extension TodayTabViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1){
            self.hidesBottomBarWhenPushed = true
            chosenObject = indexPath.item
            self.performSegue(withIdentifier: "fromTodayToTasksView", sender: self)
            self.hidesBottomBarWhenPushed = false
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
           let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.rounedView?.backgroundColor = UIColor.blue
        }
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.rounedView?.backgroundColor = selectedTaskCell.cellColor
        }
    }
    
}

// MARK: - UITableViewDataSource protocol
extension TodayTabViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = (section == 0) ? timeTableArray.count : tasksArray.count ;
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = (section == 0) ? "Расписание" : "Задания" ;
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if (indexPath.section == 0) { //Берем расписание
            let identifier = (indexPath.section == 0) ? TimetableCellIdentifier : TasksCellIdentifier ;
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TimetableTableViewCell
            
            cell.initWithTimetable(model: timeTableArray[indexPath.item])

            return cell
            
        }else{
            let identifier = (indexPath.section == 0) ? TimetableCellIdentifier : TasksCellIdentifier ;
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!  TaskTableViewCell
            //cell.selectionStyle = .none
            cell.initWithTask(model: tasksArray[indexPath.item], forSortingType: "Today")
            
            return cell
        }

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
            sectionHeaderLabel.text = "Расписание"
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
