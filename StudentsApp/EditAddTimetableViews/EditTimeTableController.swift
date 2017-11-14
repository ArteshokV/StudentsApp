//
//  EditTimeTableController.swift
//  StudentsApp
//
//  Created by AgentSamogon on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class EditTimeTableController: UIViewController {
    
    private var TimeTableChangesArray: Array<Array<TimetableModel>> = TimetableModel.getTimetableForChanges()
    private var TimetableCellIdentifier = "TimeTableCell"
    
    let WeekDaysNamesInString = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье", "Одиночные даты"]
    
    let appDesign = CustomApplicationLook()

    @IBOutlet weak var CompleteButton: UIButton!
    @IBOutlet weak var TableOfClasses: UITableView!
    
    let EmptyCellIdentifier = "EmptyCell"
    
    @IBAction func TestAction(_ sender: Any) {
        print(TimeTableChangesArray.count)
    }
    func GetClass (GetterClass: TimetableModel) {
        //TimeTableModelArray.append(GetterClass)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddButtonPress") {
        }
    }
    
    @IBAction func AddButtonPressed (_ sender:Any) {
        self.performSegue(withIdentifier: "AddButtonPress", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDesign.initBackground(ofView: self.view)
        TableOfClasses.backgroundColor = UIColor.clear
        CompleteButton.isHidden = true
        if(!UserDefaults.standard.bool(forKey: "databaseIsInited")){CompleteButton.setTitle("Начать работу", for: .normal)}
        
        setupNavigationBar()
        
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TableOfClasses.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
        TableOfClasses.register(UITableViewCell.self, forCellReuseIdentifier: EmptyCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TimeTableChangesArray = TimetableModel.getTimetableForChanges()
        TableOfClasses.reloadData()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupNavigationBar(){
        self.hidesBottomBarWhenPushed = true
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.005)
        self.navigationItem.title = "Расписание"
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(EditTimeTableController.AddButtonPressed(_:)))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
    }

}

// MARK: - UITableViewDelegate protocol
extension EditTimeTableController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension EditTimeTableController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TimeTableChangesArray.count
    }
    
    // Получим количество строк для конкретной секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeTableChangesArray[section].count != 0 ? TimeTableChangesArray[section].count : 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    
    
    // Получим данные для использования в ячейке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(TimeTableChangesArray[indexPath.section].count != 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: TimetableCellIdentifier, for: indexPath) as! TimetableTableViewCell
            cell.EditMode = true
            cell.initWithTimetable(model: TimeTableChangesArray[indexPath.section][indexPath.row])
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.initHeader(withWidth: tableView.frame.width, andMainText: WeekDaysNamesInString[section])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.initFooter(withWidth: tableView.frame.width)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderFooterViewClass.viewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
}
