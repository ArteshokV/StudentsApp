//
//  TodayTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 10.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class TodayTabViewController: UIViewController,NSFetchedResultsControllerDelegate,  UINavigationControllerDelegate{

    // MARK: - Variables
    var tomorrowButton: UIButton!
    var todayButton: UIButton!
    
    @IBOutlet weak var TableViewOutlet: UITableView!
    
    let TimetableCellIdentifier = "TimetableCell"
    let TasksCellIdentifier = "TaskCell"
    let TopCellIdentifier = "TopCell"
    let EmptyCellIdentifier = "EmptyCell"
    
    var shownFirstTime = 1
    var workingWithToday = true
    
    var timeTableArray: [TimetableModel]! //Добавляем пустой массив расписания
    var tasksArray: [TaskModel]! //Добавляем пустой массив заданий
    var activitiesArray: [ActivitiesModel]! //Добавляем пустой массив заданий
    var timeTableFetchController: NSFetchedResultsController<TimeTable>!
    var tasksFetchController: NSFetchedResultsController<Tasks>!
    var activitiesFetchController: NSFetchedResultsController<Activities>!
    var viewHasChanges: Bool = false
    var changesController: NSFetchedResultsController<NSFetchRequestResult>!
    
    var chosenObject = 0

    let appDesign = CustomApplicationLook()
    var blurEffectView: UIVisualEffectView?
    
    
    // MARK: - View Functions
    override func viewWillAppear(_ animated: Bool) {
        if(!(self.navigationController?.navigationBar.isHidden)!){
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        super.viewWillAppear(animated)
        
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        //self.navigationController?.navigationBar.alpha = 0
        
        if(viewHasChanges){
            viewHasChanges = false
            //if(changesController == timeTableFetchController){
                let cust = CustomDateClass()
                timeTableArray = TimetableModel.getTimetable(Date: cust)
            //}
            //if(changesController == tasksFetchController){
                tasksArray = TaskModel.getTasksForToday()
            //}
            
            //if(changesController == activitiesFetchController){
                activitiesArray = ActivitiesModel.getActivitiesForToday()
            //}
            TableViewOutlet.reloadData()
            self.TableViewOutlet.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top , animated: false)
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        //shownFirstTime = 1
        if(shownFirstTime == 1){
            UIView.animate(withDuration: 1.0, delay: 0.5, options: [.curveEaseInOut], animations: {
                let startCell = IndexPath(row: 0, section: 1)
                self.TableViewOutlet.scrollToRow(at: startCell, at: .bottom , animated: false)
                }, completion: nil)
            shownFirstTime = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(TimetableModel.getTimetableForChanges())
        //Полуение массива предметов
        let cust = CustomDateClass()
        timeTableArray = TimetableModel.getTimetable(Date: cust)
        tasksArray = TaskModel.getTasksForToday()
        activitiesArray = ActivitiesModel.getActivitiesForToday()
        
        timeTableFetchController = TimetableModel.setupFetchController(forDate: cust)
        timeTableFetchController.delegate = self
        tasksFetchController = TaskModel.setupFetchController()
        tasksFetchController.delegate = self
        activitiesFetchController = ActivitiesModel.setupFetchController()
        activitiesFetchController.delegate = self
        
        appDesign.initBackground(ofView: self.view)
        blurEffectView = appDesign.backgroundBlurView
        blurEffectView!.alpha = 0.0;
        
        TableViewOutlet.backgroundColor = UIColor.clear
        
        TableViewOutlet.rowHeight = UITableViewAutomaticDimension
        TableViewOutlet.estimatedRowHeight = 120
        TableViewOutlet.autoresizesSubviews = true

        // Do any additional setup after loading the view.
        let taskCellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        TableViewOutlet.register(taskCellNib, forCellReuseIdentifier: TasksCellIdentifier)
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TableViewOutlet.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
        let topCellNib = UINib(nibName: "UpperTodayTableViewCell", bundle: nil)
        TableViewOutlet.register(topCellNib, forCellReuseIdentifier: TopCellIdentifier)
        TableViewOutlet.register(UITableViewCell.self, forCellReuseIdentifier: EmptyCellIdentifier)

    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        viewHasChanges = true
        changesController = controller
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromTodayToTasksView"){
            let taskVC = segue.destination as! TaskViewEditViewController
            taskVC.taskModelObject = tasksArray[chosenObject]
        }
    }

}

// MARK: - UIScrollViewDelegate protocol
extension TodayTabViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //self.view.layer.removeAllAnimations()
        //self.TableViewOutlet.setContentOffset(TableViewOutlet.contentOffset, animated: false)
        //TableViewOutlet.layer.removeAllAnimations()
        
        
        blurEffectView!.alpha = scrollView.contentOffset.y/240///180;
        //self.tabBarController?.tabBar.alpha = scrollView.contentOffset.y/240
    }
}

// MARK: - UITableViewDelegate protocol
extension TodayTabViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if((indexPath.section == 3)||(activitiesArray.count == 0)&&(indexPath.section != 1))&&(tasksArray.count != 0){
            self.hidesBottomBarWhenPushed = true
            chosenObject = indexPath.item
            self.performSegue(withIdentifier: "fromTodayToTasksView", sender: self)
            self.hidesBottomBarWhenPushed = false
        }
    }
    
    
    /*
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if(indexPath.section == 2){
           let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.setHighlighted(false, animated: false)
            selectedTaskCell.rounedView?.backgroundColor = selectedTaskCell.cellColor
        }
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if(indexPath.section == 2){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.rounedView?.backgroundColor = UIColor.clear
        }
    }
    */
}

// MARK: - UITableViewDataSource protocol
extension TodayTabViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return activitiesArray.count != 0 ? 4 : 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return  1
            
        case 1:
            return timeTableArray.count != 0 ? timeTableArray.count : 1
            
        case 2:
            return activitiesArray.count != 0 ? activitiesArray.count : (tasksArray.count != 0 ? tasksArray.count : 1)
            
        case 3:
            return tasksArray.count
            
        default:
            return 1
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if(indexPath.section == 0){
            let identifier = TopCellIdentifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UpperTodayTableViewCell
            
            return cell
        }
        
        if (indexPath.section == 1) { //Берем расписание
            if(timeTableArray.count != 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: TimetableCellIdentifier, for: indexPath) as! TimetableTableViewCell
                cell.initWithTimetable(model: timeTableArray[indexPath.row])
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
            
        }else if ((indexPath.section == 3)||(activitiesArray.count == 0)){
            if(tasksArray.count != 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: TasksCellIdentifier, for: indexPath) as!  TaskTableViewCell
                cell.initWithTask(model: tasksArray[indexPath.item], forSortingType: "Today")
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCellIdentifier, for: indexPath)
                cell.backgroundColor = appDesign.underLayerColor
                appDesign.managedLayersContext.append(cell)
                
                cell.textLabel?.text = "У Вас нет заданий!"
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
        }else{
            let identifier = TasksCellIdentifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!  TaskTableViewCell
            
            cell.initWithActivity(model: activitiesArray[indexPath.row], forSortingType: "Today")
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section {
        case 0:
            
            return  self.view.frame.height - (self.tabBarController?.tabBar.frame.height)! - 50
            
        case 1:
            return 100//120
            
        case 2,3:
            return 80//UITableViewAutomaticDimension
            
        default:
            return 1
        }
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){
            return nil
        }
        let header = HeaderFooterViewClass.initHeader(withWidth: tableView.frame.width, andMainText: "")
        header.mainHeaderLabel?.textAlignment = .left
        if(section == 1){
            header.mainHeaderLabel?.text = "Расписание"
        }else if ((section == 3)||(activitiesArray.count == 0)){
            header.mainHeaderLabel?.text = "Задания"
            
            let numberOfExpiredTasks = TaskModel.getNumberOfExpiredTasks()
            if(numberOfExpiredTasks != "0"){
                header.attributeHeaderLabel?.text = "Просрочено: " + numberOfExpiredTasks
                header.attributeHeaderLabel?.isHidden = false
            }
        }else{
            header.mainHeaderLabel?.text = "Ближайшие мероприятия"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section == 0){
            return nil
        }
        
        let footer = HeaderFooterViewClass.initFooter(withWidth: tableView.frame.width)
        if(section == 1){
            footer.leftFooterButton?.addTarget(self, action: #selector(todayButtonPressed), for: .touchUpInside)
            footer.leftFooterButton?.isHidden = false
            todayButton = footer.leftFooterButton!
            
            footer.rightFooterButton?.addTarget(self, action: #selector(tomorrowButtonPressed), for: .touchUpInside)
            footer.rightFooterButton?.isHidden = false
            tomorrowButton = footer.rightFooterButton!
            
            if(workingWithToday){
                footer.leftFooterButton?.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            }else{
                footer.rightFooterButton?.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            }
        }
        
        return footer
    }
    
    
    
    @objc func todayButtonPressed(_ sender: UIButton!){
        if(!workingWithToday){
            todayButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            tomorrowButton.backgroundColor = UIColor.clear
            let oldLengthOfSection = timeTableArray.count != 0 ? timeTableArray.count : 1
            workingWithToday = true
            let today = CustomDateClass()
            self.timeTableArray = TimetableModel.getTimetable(Date: today)
            self.timeTableFetchController = TimetableModel.setupFetchController(forDate: today)
            self.timeTableFetchController.delegate = self
            var changesNumber: Int
            if(timeTableArray.count == 0)&&(oldLengthOfSection == 1){
                changesNumber = 0
            }else{
                changesNumber = timeTableArray.count - oldLengthOfSection
            }
            updateTimetableSection(withChangesNumber: changesNumber)
        }
    }
    
    @objc func tomorrowButtonPressed(_ sender: UIButton!){
        if(workingWithToday){
            todayButton.backgroundColor = UIColor.clear
            tomorrowButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            let oldLengthOfSection = timeTableArray.count != 0 ? timeTableArray.count : 1
            workingWithToday = false
            let nextDay = CustomDateClass()
            nextDay.switchToNextDay()
            timeTableArray = TimetableModel.getTimetable(Date: nextDay)
            self.timeTableFetchController = TimetableModel.setupFetchController(forDate: nextDay)
            self.timeTableFetchController.delegate = self
            var changesNumber: Int
            if(timeTableArray.count == 0)&&(oldLengthOfSection == 1){
                changesNumber = 0
            }else{
                changesNumber = timeTableArray.count - oldLengthOfSection
            }
            updateTimetableSection(withChangesNumber: changesNumber)
        }
    }
    
    func updateTimetableSection(withChangesNumber: Int){

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            //let startCell = IndexPath(row: self.timeTableArray.count/2, section: 1)
            self.TableViewOutlet.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top , animated: false)
            //self.TableViewOutlet.scrollToRow(at: startCell, at: .middle , animated: false)
            
        }, completion: { _ in
            if(withChangesNumber == 0){
                self.TableViewOutlet.beginUpdates()
                self.TableViewOutlet.reloadSections(IndexSet(integer: 1), with: .fade)
                self.TableViewOutlet.endUpdates()
                return
            }
            
            var indexPathsToChange: Array<IndexPath> = Array()
            for rowToChange in 1...abs(withChangesNumber){
                indexPathsToChange.append(IndexPath(row: rowToChange, section: 1))
            }
            self.TableViewOutlet.beginUpdates()
            
            if(withChangesNumber > 0){
                self.TableViewOutlet.insertRows(at: indexPathsToChange, with: .middle)
            }else if(withChangesNumber < 0){
                indexPathsToChange.removeLast()
                self.TableViewOutlet.deleteRows(at:indexPathsToChange, with: .middle)
            }
            

            //UIView.transition(with: self.view...
 
            self.TableViewOutlet.endUpdates()
            self.TableViewOutlet.reloadSections(IndexSet(integer: 1), with: .fade)
        })
 
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : HeaderFooterViewClass.viewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 0){return 0}
        if(section == 1){return HeaderFooterViewClass.viewHeight}
        return 40
    }
}
