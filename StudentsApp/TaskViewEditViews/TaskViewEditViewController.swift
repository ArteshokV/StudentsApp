//
//  TaskViewEditViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 12.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TaskViewEditViewController: UIViewController {

    
    @IBOutlet weak var TaskViewTable: UITableView!
    
    var taskModelObject: TaskModel?
    var rounedView: UIView?
    let appDesign = CustomApplicationLook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        appDesign.initBackground(ofView: self.view)
        
      
        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = appDesign.tabBarColor
        
       
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(TaskViewEditViewController.EditButtonPressed(_:)))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        let item = UINavigationItem(title: "EDIT")
        item.rightBarButtonItem = rightEditBarButtonItem
        let topBar = UINavigationBar(frame: self.navigationController!.navigationBar.bounds)
        topBar.pushItem(item, animated: false)
        
        TaskViewTable.backgroundColor = UIColor.clear
        let taskCellNib = UINib(nibName: "TaskTapViewCell", bundle: nil)
        TaskViewTable.register(taskCellNib, forCellReuseIdentifier: "TaskTapCell")
       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        //self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(move))
        //self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

        self.TaskViewTable.reloadData()
    }
    
    @objc func move(_ sender: UIGestureRecognizer!){
        //print(sender.location(in: self.view))
        let alphaBar = abs(sender.location(in: self.view).x) / self.view.frame.width
        //print((self.navigationController?.navigationBar.frame.height)! * alphaBar)
        //self.navigationController?.navigationBar.alpha = alphaBar
        self.navigationController?.navigationBar.frame.origin.y = 85//(self.navigationController?.navigationBar.frame.height)! * alphaBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "fromTaskViewToTaskEdit"){
            let taskEC = segue.destination as! TaskEditViewController
            taskEC.taskEditObject = taskModelObject
            taskEC.isEditing = true
        }
    }
    

    
    @IBAction func EditButtonPressed(_ sender: Any) {
    
            self.hidesBottomBarWhenPushed = true
            self.performSegue(withIdentifier: "fromTaskViewToTaskEdit", sender: self)
        if (taskModelObject == nil) {
            self.navigationController?.popViewController(animated: false)
        }
    }
   
    
   
}

extension TaskViewEditViewController: UITableViewDelegate {
    
}
    
extension TaskViewEditViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { // Получим количество секций
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else { return 5 }
    }
    
   
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Получим данные для использования в ячейке
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTapCell", for: indexPath) as! TaskTapViewCell
        if indexPath.section == 0 {
            cell.label.text = " "
            cell.backgroundColor = UIColor.clear
        }
        else {
            cell.backgroundColor = CustomApplicationLook.getUnderLayerColor()
        switch indexPath.row {
        case 0:
            cell.label.textColor = appDesign.mainTextColor
            cell.label.text = taskModelObject?.taskNameShort
            cell.label.font = UIFont.italicSystemFont(ofSize: 17)
            cell.label.textAlignment = .center
            break
        case 1:
            cell.label.textColor = appDesign.mainTextColor
            cell.label.text = (taskModelObject?.taskDescription)! == "" ? "Подробное описание задания отсутствует" : " " + (taskModelObject?.taskDescription)!
            cell.label.textAlignment = .justified
            break
        case 2:
            cell.label.textColor = appDesign.mainTextColor
            cell.label.text = "Дата сдачи: " + (taskModelObject?.taskDate?.stringFromDate())!
            cell.label.textAlignment = .left
            break
        case 3:
            cell.label.textColor = appDesign.mainTextColor
            cell.label.textAlignment = .left
            switch taskModelObject?.taskPriority {
            case 0?:
                cell.label.text = "Приоритет: низкий"
                break
            case 1?:
                cell.label.text = "Приоритет: средний"
                break
            case 2?:
                cell.label.text = "Приоритет: высокий"
                break
            default:
                cell.label.text = ""
                break
            }
            
            break
        case 4:
            cell.label.textAlignment = .center
            switch taskModelObject?.taskStatus {
            case 0?:
                cell.label.text = "Не выполнено"
                cell.label.textColor = UIColor.red
                break
            case 1?:
                cell.label.text = "Выполнено"
                cell.label.textColor = UIColor.green
                break
            default:
                cell.label.text = ""
                break
            }
            break
        default:
            cell.label.text = ""
            break
        }
        }
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = HeaderFooterViewClass.initHeader(withWidth: tableView.frame.width, andMainText: "")
            header.mainHeaderLabel?.textAlignment = .center
            header.mainHeaderLabel?.text = taskModelObject?.taskSubject! == "" ? "Дополнительно" : (taskModelObject?.taskSubject!)!
           // return HeaderFooterViewClass.getViewForHeaderInSectionWithLabelAndParametrs(textFronLabel: taskModelObject?.taskSubject! == "" ? "Дополнительно" : (taskModelObject?.taskSubject!)!, tableView: tableView, height: 50, cornerRadiusWidth: 8, cornerRadiusHeight: 8)
        return header
        }
        else {return nil}
       
        }
        
        
        
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            //return HeaderFooterViewClass.getViewForFooterInSectionWithLabelAndParametrs(tableView: tableView, height: 15, distance: 10, cornerRadiusWidth: 15, cornerRadiusHeight: 50)
            let footer = HeaderFooterViewClass.initFooter(withWidth: tableView.frame.width)
            return footer
        }
        else {
            return nil
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 25
        }
        else { return 1 }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
    }
        else { return 1 }
    }
}
