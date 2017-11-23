//
//  SubjectsTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class SubjectsTabViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var subjectsArray: [SubjectModel]! //Добавляем пустой массив предметов
    
    var subjectsFetchController: NSFetchedResultsController<Subjects>!
    var viewHasChanges: Bool = false
    
    //@IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var SubjectTabTableView: UITableView!
    let subjectsTabCellIdentifier = "SubjectsTabTableViewCell" //Идентификатор ячейки
    
    let appDesign = CustomApplicationLook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        appDesign.initBackground(ofView: self.view)
        
        SubjectTabTableView.backgroundColor = UIColor.clear
        //titleLabel.textColor = appDesign.mainTextColor
        //appDesign.managedMainLablesContext.append(titleLabel)
        
        //Полуение массива предметов
        subjectsArray = SubjectModel.getSubjects()
        subjectsFetchController = SubjectModel.setupFetchController()
        subjectsFetchController.delegate = self
        
        let subjectsCellNib = UINib(nibName: "SubjectsTabTableViewCell", bundle: nil)
        SubjectTabTableView.register(subjectsCellNib, forCellReuseIdentifier: subjectsTabCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(viewHasChanges){
            viewHasChanges = false
            subjectsArray = SubjectModel.getSubjects()
            SubjectTabTableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        viewHasChanges = true
    }
}


// MARK: - UITableViewDelegate protocol
extension SubjectsTabViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - UITableViewDataSource protocol
extension SubjectsTabViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsArray.count / 2 + 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = subjectsTabCellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SubjectsTabTableViewCell
        
        cell.parentController = self
        
        //Вычисляем количество предметов в ячейке - 1 или 2?
        if(subjectsArray.count / 2 + 1 == indexPath.row+1){ // Если последний ряд
            if(subjectsArray.count % 2 == 0){ // В последнем ряду одна кнока ADD
                cell.initRowWithAddButton()
            }else{ // В последнем ряду две ячейки - предмет и кнопка ADD
                cell.initRowWith(LeftModel: subjectsArray[indexPath.row*2])
            }
        }else{
            cell.initRowWith(leftModel: subjectsArray[indexPath.row*2], rightModel: subjectsArray[indexPath.row*2+1])
        }
            
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.initHeader(withWidth: tableView.frame.width, andMainText: "")
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return HeaderFooterViewClass.initFooter(withWidth: tableView.frame.width)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UIScreen.main.bounds.width/2
    }
 
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  30
    }
    
}

