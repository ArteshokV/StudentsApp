//
//  TasksTabViewController.swift
//  StudentsApp
//
//  Created by Admin on 06.10.17.
//  Copyright © 2017 Владислав Саверский. All rights reserved.
//

import UIKit

class TasksTabViewController: UIViewController{
    // MARK: - Variables
    var parametr: String! // переменная для выбота типа сортировки
    var taskOrActivity: String! // переменная для выбора заданий или мереоприятий
    var counter: Int!
    var chosenObject: TaskModel?
    
    var ActivitiesAtSubjectArray: [[ActivitiesModel]] = []
    var ActivitiesAtDayArray: [[ActivitiesModel]] = []
    var TasksAtDayArray: [[TaskModel]] = []
    var TasksAtSubjectArray: [[TaskModel]] = []
    var TasksAtPriorityArray: [[TaskModel]] = []
    
    @IBOutlet weak var taskTable: UITableView!
    
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    
    
    @IBOutlet weak var Segment: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  taskTable.estimatedRowHeight = 120
      //  taskTable.autoresizesSubviews = true
        
        taskTable.backgroundColor = UIColor.clear
       // self.view.backgroundColor = UIColor(red: 120/255, green: 120/255, blue: 250/255, alpha: 0.25) //топ цвет
        counter = 1
       // let blurEffectView: UIBlurEffect
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackGroundImage")
        self.view.insertSubview(backgroundImage, at: 0)

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 1)
        
        taskOrActivity = "task"//выбираем просмотр заданий
        parametr = "time" //выбираем сортировку по времени
        
        let taskCellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        taskTable.register(taskCellNib, forCellReuseIdentifier: "TasksCell")
        
        // Задаем страртове цета кнопок
        
        taskButton.tintColor = UIColor.red
        activityButton.tintColor = UIColor.gray
        
        ActivitiesAtSubjectArray = ActivitiesModel.getActivitiesGroupedBySubject()
        ActivitiesAtDayArray = ActivitiesModel.getActivitiesGroupedByDate()
        TasksAtDayArray = TaskModel.getTasksGroupedByDate()
        TasksAtSubjectArray = TaskModel.getTasksGroupedBySubject()
        TasksAtPriorityArray = TaskModel.getTasksGroupedByPriority()
    
        
        // Do any additional setup after loading the view.
    }
        
   
   
    
    @IBAction func taskChooseButton(_ sender: Any) { //выбор просмотра заданий
        taskButton.tintColor = UIColor.red
        activityButton.tintColor = UIColor.gray
        taskOrActivity = "task"
        if counter == 0 {
        Segment.insertSegment(withTitle: "Приоритет", at: 2, animated: true)
            counter = 1
        }
        taskTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        taskTable.scrollToRow(at: index, at: .top, animated: true)
    }
    
    
    @IBAction func acrivityChooseButton(_ sender: Any) {//выбор просмотра мероприятий
        taskButton.tintColor = UIColor.gray
        activityButton.tintColor = UIColor.red
        taskOrActivity = "activity"
        if parametr == "priority"  { //так как в мероприятиях нет сортировки по приоритетам - перейдем в сортировку по датам
            Segment.selectedSegmentIndex = 1
            parametr = "time"
        }
        if counter == 1 {
        Segment.removeSegment(at: 2, animated: true)
            counter = 0
        }
        taskTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        taskTable.scrollToRow(at: index, at: .top, animated: true)
        
    }
    
    
    @IBAction func SegmentChenged(_ sender: Any) {
        switch Segment.selectedSegmentIndex {
        case 0:
            parametr = "subject"
            break
        case 1:
            parametr = "time"
            break
        case 2:
            parametr = "priority"
            break
        default:
            parametr = "time"
            break
        }
        taskTable.reloadData()
        let index = IndexPath.init(row: 0, section: 0) //Прокрутка таблицы вверх при переключении
        taskTable.scrollToRow(at: index, at: .top, animated: true)
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
    }
    
    func makeRoundedMask(forTop: Bool, bounds: CGRect) -> CAShapeLayer {
        let corners:UIRectCorner = (forTop ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii:CGSize(width:15.0, height:15.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
}




extension TasksTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(taskOrActivity == "task"){
            self.hidesBottomBarWhenPushed = true
            switch parametr {
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
        if(taskOrActivity == "task"){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.setHighlighted(false, animated: false)
            selectedTaskCell.rounedView?.backgroundColor = selectedTaskCell.cellColor
        }
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if(taskOrActivity == "task"){
            let selectedTaskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
            selectedTaskCell.setHighlighted(false, animated: false)
            selectedTaskCell.rounedView?.backgroundColor = UIColor.clear
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension TasksTabViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int { // Получим количество секций
        if taskOrActivity == "task" { // для вывода заданий
            if parametr == "time" {
            return TasksAtDayArray.count
        }
        
            else { if parametr == "subject" {
                return TasksAtSubjectArray.count
            }
                  else { if parametr == "priority" {
                return (TasksAtPriorityArray.count - 1)
                }
                    else { return 0 }
                }
                
            }
        }
        
        else { //для вывода мероприятий
             if parametr == "time" {
                return ActivitiesAtDayArray.count
            }
                
            else { if parametr == "subject" {
                return ActivitiesAtSubjectArray.count
            }
            else {  return 0  }
            
        }
    }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Получим количество строк для конкретной секции
      
      if taskOrActivity == "task" {  // для вывода заданий
        if parametr == "time" {
        return TasksAtDayArray[section].count
        }
       else {
        if parametr == "subject" {
           
            return TasksAtSubjectArray[section].count
        }
        else {
            if parametr == "priority" {
                return TasksAtPriorityArray[section].count
            }
            else {return 0}
        }
        }
        }
     else { //для вывода мероприятий
        if parametr == "time" {
            return ActivitiesAtDayArray[section].count
        }
        else {
            if parametr == "subject" {
                return ActivitiesAtSubjectArray[section].count
            }
            else {return 0}
        }
        }
        
    }
    
    
  /*  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // Получим заголовок для секции
        
        if taskOrActivity == "task" {  // для вывода заданий
            switch parametr {
            case "time":
            return TasksAtDayArray[section][0].taskDate?.stringFromDate()
            case "subject":
            return TasksAtSubjectArray[section][0].taskSubject
            case "priority":
                switch TasksAtPriorityArray[section][0].taskPriority! {
                case 2:
                    return "Высокий приоритет"
                case 1:
                    return "Средний приоритет"
                case 0:
                    return "Низкий приоритет"
                default:
                    return " "
                }
            default:
            return " "
            
        }
        }
        else { //для вывода мероприятий
            if parametr == "time" {
                return ActivitiesAtDayArray[section][0].activityDate?.stringFromDate()
            }
            else {
                if parametr == "subject" {
                    return ActivitiesAtSubjectArray[section][0].activitySubject
                }
                else {return " "}
                
            }
        }
    }
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Получим данные для использования в ячейке
         let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath) as! TaskTableViewCell
        
        
        if taskOrActivity == "task" { // для вывода заданий
        if parametr == "time" { // Вывод данных для сортировки заданий по дате
             cell.initWithTask(model: TasksAtDayArray[indexPath.section][indexPath.row], forSortingType: "Сроки")
            
        }
        
        if parametr == "subject" { // Вывод данных для сортировки заданий по предметам
            cell.initWithTask(model: TasksAtSubjectArray[indexPath.section][indexPath.row], forSortingType: "Предметы")
        }
        
        if parametr == "priority" { // Вывод данных для сортировки заданий по приоритету
            cell.initWithTask(model: TasksAtPriorityArray[indexPath.section][indexPath.row], forSortingType: "Приоритет")
        }
        }
 
        else {
            if parametr == "time" { // Вывод данных для сортировки мероприятий по дате
                cell.initWithActivity(model: ActivitiesAtDayArray[indexPath.section][indexPath.row], forSortingType: "Сроки")
            }
            
            if parametr == "subject" { // Вывод данных для сортировки мероприятий по предметам
                cell.initWithActivity(model: ActivitiesAtSubjectArray[indexPath.section][indexPath.row], forSortingType: "Предметы")
            }
        }
        
        //cell.tintColor = UIColor.white
        cell.MiddleDescriptionLabel.textColor = UIColor.white
        cell.TopSubjectLabel.textColor = UIColor.lightGray
        cell.BottomEdgeDateLabel.textColor = UIColor.lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()
       /* sectionHeaderView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:50)
        sectionHeaderView.layer.mask = makeRoundedMask(forTop: true, bounds: sectionHeaderView.bounds)
        sectionHeaderView.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:10,y:0,width:(tableView.frame.width - 10),height:50)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)
        sectionHeaderLabel.textColor = UIColor.white
        //sectionHeaderLabel.textAlignment = NSTextAlignment.center
        
 
       
        switch parametr {
        case "time":
            sectionHeaderLabel.text = TasksAtDayArray[section][0].taskDate?.stringFromDate()
        case "subject":
            sectionHeaderLabel.text = TasksAtSubjectArray[section][0].taskSubject == "" ? "Дополнительно" : TasksAtSubjectArray[section][0].taskSubject
        case "priority":
            switch TasksAtPriorityArray[section][0].taskPriority! {
            case 2:
                sectionHeaderLabel.text = "Высокий приоритет"
            case 1:
                sectionHeaderLabel.text = "Средний приоритет"
            case 0:
                sectionHeaderLabel.text = "Низкий приоритет"
            default:
                sectionHeaderLabel.text = " "
            }
        default:
            sectionHeaderLabel.text = " "
        }
        
       // sectionHeaderView.addSubview(sectionHeaderLabel)
 */
        
        switch parametr {
        case "time":
            return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: (TasksAtDayArray[section][0].taskDate?.stringFromDate())!, tableView: tableView)
        case "subject":
            return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: TasksAtSubjectArray[section][0].taskSubject! == "" ? "Дополнительно" : TasksAtSubjectArray[section][0].taskSubject!, tableView: tableView)
        case "priority":
            switch TasksAtPriorityArray[section][0].taskPriority! {
            case 2:
                 return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: "Высокий приоритет", tableView: tableView)
            case 1:
                return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: "Средний приоритет", tableView: tableView)
            case 0:
                return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: "Низкий приоритет", tableView: tableView)
            default:
                return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: " ", tableView: tableView)
            }
        default:
            return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: " ", tableView: tableView)
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        //return HeaderFooterViewClass.getViewForFooterInSectionWithLabel(tableView: tableView)
        return HeaderFooterViewClass.getViewForFooterInSectionWithLabelAndParametrs(tableView: tableView, height: 20, distance: 10, cornerRadiusWidth: 15, cornerRadiusHeight: 15)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    }
