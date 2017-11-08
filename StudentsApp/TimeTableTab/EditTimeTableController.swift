//
//  EditTimeTableController.swift
//  StudentsApp
//
//  Created by AgentSamogon on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class EditTimeTableController: UIViewController {
    
    private var TimeTableModelArray: Array<TimetableModel> = Array()
    private var TimetableCellIdentifier = "TimeTableCell"

    @IBOutlet weak var CompleteButton: UIButton!
    @IBOutlet weak var TableOfClasses: UITableView!
    
    
    @IBAction func TestAction(_ sender: Any) {
        print(TimeTableModelArray.count)
    }
    func GetClass (GetterClass: TimetableModel) {
        TimeTableModelArray.append(GetterClass)
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
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.005)
        self.navigationItem.title = "Расписание"
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(EditTimeTableController.AddButtonPressed(_:)))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
        let timetableCellNib = UINib(nibName: "TimetableTableViewCell", bundle: nil)
        TableOfClasses.register(timetableCellNib, forCellReuseIdentifier: TimetableCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension EditTimeTableController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Получим количество строк для конкретной секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeTableModelArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    
    
    // Получим данные для использования в ячейке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimetableCellIdentifier, for: indexPath) as! TimetableTableViewCell
        cell.initWithTimetable(model: TimeTableModelArray[indexPath.item])
        return cell
    }
    
}
