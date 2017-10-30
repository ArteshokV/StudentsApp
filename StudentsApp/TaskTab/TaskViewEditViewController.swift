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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackGroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 1)
        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.005)
        
        /* let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Редактировать", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TaskViewEditViewController.EditButtonPressed(_:))) */
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(TaskViewEditViewController.EditButtonPressed(_:)))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        
        
        //navigationController?.navigationBar.titleTextAttributes = NSForegroundColorAttributeName: UIColor.red
        //self.navigationController?.navigationBar.tintColor = UIColor.red
        //self.navigationController?.navigationBar.barTintColor = UIColor.clear
       
        
        
        TaskViewTable.backgroundColor = UIColor.clear
        let taskCellNib = UINib(nibName: "TaskTapViewCell", bundle: nil)
        TaskViewTable.register(taskCellNib, forCellReuseIdentifier: "TaskTapCell")
       
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*    func getSubview (label:UILabel) -> UIView {
        rounedView = UIView(frame: label.frame)
        rounedView?.layer.borderColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25).cgColor
        rounedView?.layer.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25).cgColor
        let roundedViewWidth = label.frame.width
        let roundedViewHeight = label.frame.height
        
        let frameOfRoundedView = CGRect(x:0, y:0, width:roundedViewWidth - 15, height:roundedViewHeight)
        
        
        
        rounedView?.layer.masksToBounds = false
        rounedView?.layer.cornerRadius = label.frame.width * 0.01
        rounedView?.layer.borderWidth = 1.5
            
            //Настройка тени
        rounedView?.layer.shadowOffset = CGSize(width:-2, height:2)
        rounedView?.layer.shadowOpacity = 1
            
            //rounedView!.backgroundColor = UIColor.lightGray
        rounedView?.frame = frameOfRoundedView
        return rounedView!
    } */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func EditButtonPressed(_ sender: Any) {
    
        
        
        
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
        switch indexPath.row {
        case 0:
            cell.label.text = taskModelObject?.taskNameShort
            cell.label.font = UIFont.italicSystemFont(ofSize: 17)
            cell.label.textAlignment = .center
            break
        case 1:
            cell.label.text = " " + (taskModelObject?.taskDescription)!
            cell.label.textAlignment = .justified
            break
        case 2:
            cell.label.text = "Дата сдачи: " + (taskModelObject?.taskDate?.stringFromDate())!
            break
        case 3:
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
            return HeaderFooterViewClass.getViewForHeaderInSectionWithLabel(textFronLabel: taskModelObject?.taskSubject! == "" ? "Дополнительно" : (taskModelObject?.taskSubject!)!, tableView: tableView)
            
        }
        else {return nil}
       
        }
        
        
        
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return HeaderFooterViewClass.getViewForFooterInSectionWithLabelAndParametrs(tableView: tableView, height: 15, distance: 10, cornerRadiusWidth: 15, cornerRadiusHeight: 50)
            
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
