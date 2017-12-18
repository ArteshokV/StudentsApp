//
//  TasksTabViewController.swift
//  StudentsApp
//
//  Created by Admin on 06.10.17.
//  Copyright © 2017 Владислав Саверский. All rights reserved.
//

import UIKit
import CoreData

class TasksTabViewController: UIViewController, NSFetchedResultsControllerDelegate{
    // MARK: - Variables
   
    //NavigationView titles
    @IBOutlet weak var navigationCloneView: UIView!
    let navigationViewWidth: CGFloat = 170
    var navigationTitleView: UIView!
    var navigationLeftTitle: UILabel!
    var navigationRightTitle: UILabel!
    var navigationPageControl: UIPageControl!
    
    //Other variables
    
    var workingWithDone: Bool = false
    var workingWithProsr: Bool = false
    var counterd = 0
    var counterp = 0
    var showDone = false
    var counterDone = 0
   // var defaultColorDoneButton:UIColor = UIColor.clear
     // переменная для выбота типа сортировки
    var taskParametr: String!
    var activitiesParametr: String!
    
    
     // переменная для выбора заданий или мереоприятий
    var counter: Int!
    var chosenObject: TaskModel?
    
    var ActivitiesAtSubjectArray: [[ActivitiesModel]] = []
    
    var ActivitiesAtDayArray: [[ActivitiesModel]] = []
    var TasksAtDayArray: [[TaskModel]] = []
    var TasksAtSubjectArray: [[TaskModel]] = []
    var TasksAtPriorityArray: [[TaskModel]] = []
    
    var tasksFetchController: NSFetchedResultsController<Tasks>!
    var activitiesFetchController: NSFetchedResultsController<Activities>!
    var viewHasChanges: Bool = false
    var changesController: NSFetchedResultsController<NSFetchRequestResult>!
    
    let appDesign = CustomApplicationLook()
    
    @IBOutlet weak var MainScrollView: UIScrollView!
    @IBOutlet weak var taskTable: UITableView!
    
    
    @IBOutlet weak var activitiesTable: UITableView!
    
    @IBOutlet weak var addTaskBarButton: UIBarButtonItem!
    @IBOutlet weak var showDoneTasksButton: UIBarButtonItem!
    
     @IBOutlet weak var addTaskButton: UIButton!
    
    
    
   
    @IBOutlet weak var taskSegment: UISegmentedControl!
    
    @IBOutlet weak var activitiesSegment: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        if(!(self.navigationController?.navigationBar.isHidden)!){
            //self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        super.viewWillAppear(animated)
        setUpNavigationBars()
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        if(viewHasChanges){
            viewHasChanges = false
            updateData()
            taskTable.reloadData()
            activitiesTable.reloadData()
        }
        if (counterDone == 0) {
            showDoneTasksButton.tintColor = appDesign.mainTextColor
        }
    }
    
    func setUpNavigationBars(){
        let barsColor = appDesign.tabBarColor.withAlphaComponent(1)
        self.navigationController?.navigationBar.barTintColor = barsColor
        navigationCloneView.backgroundColor = barsColor
        self.navigationController?.navigationBar.tintColor = appDesign.subTextColor
        navigationLeftTitle.textColor = appDesign.mainTextColor
        navigationRightTitle.textColor = appDesign.mainTextColor
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: appDesign.mainTextColor]
    }
 
     // MARK: - Navigation
    
    func updateData(){
        //defaultColorDoneButton = showDoneTasksButton.tintColor!
        
        
        if(changesController == tasksFetchController){
            TasksAtDayArray = TaskModel.getTasksGroupedByDate(forDoneTasks: showDone)
            TasksAtSubjectArray = TaskModel.getTasksGroupedBySubject(forDoneTasks: showDone)
            TasksAtPriorityArray = TaskModel.getTasksGroupedByPriority(forDoneTasks: showDone)
        }
        
        if(changesController == activitiesFetchController){
            ActivitiesAtSubjectArray = ActivitiesModel.getActivitiesGroupedBySubject()
            ActivitiesAtDayArray = ActivitiesModel.getActivitiesGroupedByDate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        configureNavigationBarTitleAndControls()
        
        //Setting other views
        tasksFetchController = TaskModel.setupFetchController()
        tasksFetchController.delegate = self
        activitiesFetchController = ActivitiesModel.setupFetchController()
        activitiesFetchController.delegate = self
        
        taskTable.backgroundColor = UIColor.clear
        activitiesTable.backgroundColor = UIColor.clear
        
        counter = 1
        
        appDesign.initBackground(ofView: self.view)
        self.navigationItem.largeTitleDisplayMode = .never
        //appDesign.managedMainButonsContext.removeAll()
        //appDesign.managedSubButonsContext.removeAll()
      
        taskParametr = "time"
        activitiesParametr = "time"
        
        let taskCellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        taskTable.register(taskCellNib, forCellReuseIdentifier: "TasksCell")
        activitiesTable.register(taskCellNib, forCellReuseIdentifier: "TasksCell")
        
        
       
        
        ActivitiesAtSubjectArray = ActivitiesModel.getActivitiesGroupedBySubject()
        ActivitiesAtDayArray = ActivitiesModel.getActivitiesGroupedByDate()
        TasksAtDayArray = TaskModel.getTasksGroupedByDate(forDoneTasks: showDone)
        TasksAtSubjectArray = TaskModel.getTasksGroupedBySubject(forDoneTasks: showDone)
        TasksAtPriorityArray = TaskModel.getTasksGroupedByPriority(forDoneTasks: showDone)
    
       // defaultColorDoneButton = showDoneTasksButton.tintColor!
        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBarTitleAndControls(){
        //Setting navigation control
        let height = self.navigationController!.navigationBar.frame.height
        navigationTitleView = UIView(frame: CGRect(x: 0, y: 0, width: navigationViewWidth, height: height) )
        navigationTitleView.clipsToBounds = true
        navigationLeftTitle = UILabel(frame: CGRect(x: 0, y: 0, width: navigationViewWidth, height: height*0.7))
        navigationRightTitle = UILabel(frame: CGRect(x: navigationViewWidth, y: 0, width: navigationViewWidth, height: height*0.7))
        navigationPageControl = UIPageControl(frame: CGRect(x: 0, y: height*0.7, width: navigationViewWidth, height: height*0.3))
        
        navigationPageControl.numberOfPages = 2
        navigationPageControl.currentPage = 0
        navigationPageControl.isEnabled = false
        navigationTitleView.addSubview(navigationLeftTitle)
        navigationTitleView.addSubview(navigationRightTitle)
        navigationTitleView.addSubview(navigationPageControl)
        navigationLeftTitle.numberOfLines = 1
        navigationLeftTitle.textAlignment = .center
        navigationLeftTitle.text = "Задания"
        navigationRightTitle.numberOfLines = 1
        navigationRightTitle.textAlignment = .center
        navigationRightTitle.text = "Мероприятия"
        
        navigationItem.titleView = navigationTitleView
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        viewHasChanges = true
        changesController = controller
    }
        

    @IBAction func showDoneTasks(_ sender: Any) {
        showDone = !showDone
        if (counterDone == 0) {
            showDoneTasksButton.tintColor = UIColor.red
            counterDone += 1
        } else {
            showDoneTasksButton.tintColor = appDesign.mainTextColor
            counterDone = 0
        }
        TasksAtDayArray = TaskModel.getTasksGroupedByDate(forDoneTasks: showDone)
        TasksAtSubjectArray = TaskModel.getTasksGroupedBySubject(forDoneTasks: showDone)
        TasksAtPriorityArray = TaskModel.getTasksGroupedByPriority(forDoneTasks: showDone)
        
        taskTable.reloadData()
        
        if (taskTable.numberOfSections != 0) {
            let index = IndexPath.init(row: 0, section: 0)
            taskTable.scrollToRow(at: index, at: .top, animated: true)
        }
    }
    
    @IBAction func addTaskButtonTouch(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        self.performSegue(withIdentifier: "fromTasksToTaskEdit", sender: self)
        self.hidesBottomBarWhenPushed = false
    }
    
     // MARK: - Buttons
    
    
    
   
    
    
    @IBAction func taskSegmentChanged(_ sender: Any) {
        switch taskSegment.selectedSegmentIndex {
        case 0:
            taskParametr = "subject"
            break
        case 1:
            taskParametr = "time"
            break
        case 2:
            taskParametr = "priority"
            break
        default:
            taskParametr = "time"
            break
        }
        if(viewHasChanges){
            viewHasChanges = false
            updateData()
        }
        taskTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        if (taskTable.numberOfSections != 0) {
        taskTable.scrollToRow(at: index, at: .top, animated: true)
        }
    }
    
    @IBAction func activitiesSegmentChanged(_ sender: Any) {
        switch activitiesSegment.selectedSegmentIndex {
        case 0:
            activitiesParametr = "subject"
            print ("\(activitiesParametr)")
            break
        case 1:
            activitiesParametr = "time"
            print ("\(activitiesParametr)")
            break
        default:
            activitiesParametr = "time"
            break
        }
        if(viewHasChanges){
            viewHasChanges = false
            updateData()
        }
        activitiesTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        activitiesTable.scrollToRow(at: index, at: .top, animated: true)
    }
    
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromTasksToTasksView"){
            let taskVC = segue.destination as! TaskViewEditViewController
            taskVC.taskModelObject = chosenObject
        }
        if(segue.identifier == "fromTasksToTaskEdit"){
            //let tOa = segue.destination as! TaskEditViewController
           // tOa.taskOrActivity = taskOrActivity
        }
      
    }
    
}

// MARK: - UIScrollViewDelegate protocol
extension TasksTabViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == MainScrollView){
            let scrollPercent = scrollView.contentOffset.x/(scrollView.frame.width)
                //scrollView.contentSize.width/2 - (scrollView.contentOffset.x + scrollView.contentSize.width/2)
            
            navigationLeftTitle.frame.origin.x = -navigationViewWidth*scrollPercent
            navigationRightTitle.frame.origin.x = navigationViewWidth-navigationViewWidth*scrollPercent
            if(scrollPercent > 0.5){
                navigationPageControl.currentPage = 1
                self.showDoneTasksButton.isEnabled = false
                self.addTaskBarButton.isEnabled = false
                
                
                
            }else{
                navigationPageControl.currentPage = 0
                self.addTaskBarButton.isEnabled = true
                self.showDoneTasksButton.isEnabled = true
                
            }
            //print(scrollPercent)
            //navigationTitle.frame.origin.x =
        }
    }
}


 // MARK: - TableView

extension TasksTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if(tableView == taskTable){
            self.hidesBottomBarWhenPushed = true
            switch taskParametr {
            case "time":
                chosenObject = TasksAtDayArray[indexPath.section][indexPath.row]
                break
            case "subject":
                chosenObject = TasksAtSubjectArray[indexPath.section][indexPath.row]
                break
            case "priority":
                chosenObject = TasksAtPriorityArray[indexPath.section][indexPath.row]
                break
            default:
                chosenObject = TasksAtDayArray[indexPath.section][indexPath.row]
                break
            }
            self.performSegue(withIdentifier: "fromTasksToTasksView", sender: self)
            self.hidesBottomBarWhenPushed = false
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if(tableView == taskTable){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.setHighlighted(false, animated: false)
            selectedTaskCell.MiddleDescriptionLabel.textColor = UIColor.red
           // selectedTaskCell.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if(tableView == taskTable){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.setHighlighted(false, animated: false)
            selectedTaskCell.MiddleDescriptionLabel.textColor = appDesign.mainTextColor
            //selectedTaskCell.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView == taskTable) {
        return taskTable.estimatedRowHeight
    }
        else {
            return activitiesTable.estimatedRowHeight
        }
    }
}

extension TasksTabViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int { // Получим количество секций
        if (tableView == taskTable) { // для вывода заданий
            if taskParametr == "time" {
            return TasksAtDayArray.count
        }
        
            else { if taskParametr == "subject" {
                return TasksAtSubjectArray.count
            }
                  else { if taskParametr == "priority" {
                return TasksAtPriorityArray.count - 1
                }
                    else { return 0 }
                }
                
            }
        }
        
        else { //для вывода мероприятий
             if activitiesParametr == "time" {
                return ActivitiesAtDayArray.count
            }
                
            else { if activitiesParametr == "subject" {
                return ActivitiesAtSubjectArray.count
            }
            else {  return 0  }
            
        }
    }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Получим количество строк для конкретной секции
        
      if (tableView == taskTable) {  // для вывода заданий
        if taskParametr == "time" {
        return TasksAtDayArray[section].count
        }
       else {
        if taskParametr == "subject" {
           
            return TasksAtSubjectArray[section].count
        }
        else {
            if taskParametr == "priority" {
                return TasksAtPriorityArray[section].count
            }
            else {return 0}
        }
        }
        }
     else { //для вывода мероприятий
        if activitiesParametr == "time" {
            return ActivitiesAtDayArray[section].count
        }
        else {
            if activitiesParametr == "subject" {
                return ActivitiesAtSubjectArray[section].count
            }
            else {return 0}
        }
        }
        
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Получим данные для использования в ячейке
         let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath) as! TaskTableViewCell
        
     
        if (tableView == taskTable) { // для вывода заданий
        if taskParametr == "time" { // Вывод данных для сортировки заданий по дате
             cell.initWithTask(model: TasksAtDayArray[indexPath.section][indexPath.row], forSortingType: "Сроки")
            
        }
        
        if taskParametr == "subject" { // Вывод данных для сортировки заданий по предметам
            cell.initWithTask(model: TasksAtSubjectArray[indexPath.section][indexPath.row], forSortingType: "Предметы")
        }
        
        if taskParametr == "priority" { // Вывод данных для сортировки заданий по приоритету
            cell.initWithTask(model: TasksAtPriorityArray[indexPath.section][indexPath.row], forSortingType: "Приоритет")
        }
        }
 
        else {
            if activitiesParametr == "time" { // Вывод данных для сортировки мероприятий по дате
                cell.initWithActivity(model: ActivitiesAtDayArray[indexPath.section][indexPath.row], forSortingType: "Сроки")
            }
            
            if activitiesParametr == "subject" { // Вывод данных для сортировки мероприятий по предметам
                cell.initWithActivity(model: ActivitiesAtSubjectArray[indexPath.section][indexPath.row], forSortingType: "Предметы")
            }
        }
        
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
        let header = HeaderFooterViewClass.initHeader(withWidth: tableView.frame.width, andMainText: "")
        header.mainHeaderLabel?.textAlignment = .left
        //var headerLabel = ""
        
        
        header.viewCornerRadius = 8.0
    if (tableView == taskTable) {
        
        switch taskParametr {
        case "time":
            let todayD = CustomDateClass()
            if (showDone == false) {
            if (TasksAtDayArray[section][0].taskDate! >= todayD) {
            header.mainHeaderLabel?.text = (TasksAtDayArray[section][0].taskDate?.stringFromDate())!
            } else {header.mainHeaderLabel?.text = "Просрочено"} }
            else {
               header.mainHeaderLabel?.text = (TasksAtDayArray[section][0].taskDate?.stringFromDate())!
            }
            break
        case "subject":
            print("\(TasksAtSubjectArray[section][0].taskSubject!)")
            header.mainHeaderLabel?.text = TasksAtSubjectArray[section][0].taskSubject! == "" ? "Дополнительно" : TasksAtSubjectArray[section][0].taskSubject!
            break
        case "priority":
            switch TasksAtPriorityArray[section][0].taskPriority! {
            case 2:
                header.mainHeaderLabel?.text = "Высокий приоритет"
                break
            case 1:
                header.mainHeaderLabel?.text = "Средний приоритет"
                break
            case 0:
                header.mainHeaderLabel?.text = "Низкий приоритет"
                break
            default:
                header.mainHeaderLabel?.text = " "
                break
            }
        default:
            header.mainHeaderLabel?.text = " "
            break
        }
            }
            else {
                switch activitiesParametr {
                case "time":
                    header.mainHeaderLabel?.text = (ActivitiesAtDayArray[section][0].activityDate?.stringFromDate())!
                    break
                case "subject":
                    header.mainHeaderLabel?.text = ActivitiesAtSubjectArray[section][0].activitySubject! == "" ? "Дополнительно" : ActivitiesAtSubjectArray[section][0].activitySubject!
                    break
                default:
                    header.mainHeaderLabel?.text = " "
                    break
                }
            }
        
       
        
        return header
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        let footer = HeaderFooterViewClass.initFooter(withWidth: tableView.frame.width)
        
        footer.viewCornerRadius = 15.0
        
        return footer
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == (tableView.numberOfSections - 1)) {
            return 50
        }
        else {return 25}
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    }
