//
//  SubjectsTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import Foundation

class SubjectsTabViewController: UIViewController {
    
    var subjectsArray: [SubjectModel]! //Добавляем пустой массив предметов
    
    @IBOutlet weak var SubjectTabTableView: UITableView!
    let subjectsTabCellIdentifier = "SubjectsTabTableViewCell" //Идентификатор ячейки
    
    let appDesign = CustomApplicationLook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.SubjectTabTableView.rowHeight = UITableViewAutomaticDimension;
        //self.SubjectTabTableView.estimatedRowHeight = 200//UIScreen.main.bounds.width/2;
        appDesign.initBackground(ofView: self.view)
        
        SubjectTabTableView.backgroundColor = UIColor.clear
        
        //Полуение массива предметов
        subjectsArray = SubjectModel.getSubjects()
        
        
        let subjectsCellNib = UINib(nibName: "SubjectsTabTableViewCell", bundle: nil)
        SubjectTabTableView.register(subjectsCellNib, forCellReuseIdentifier: subjectsTabCellIdentifier)
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
        let sectionHeaderView = UIView()
        sectionHeaderView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:10)
        sectionHeaderView.layer.mask = makeRoundedMask(forTop: true, bounds: sectionHeaderView.bounds)
        sectionHeaderView.backgroundColor = CustomApplicationLook.getUnderLayerColor()
            //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:10)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        
        sectionHeaderLabel.text = ""
        
        sectionHeaderView.addSubview(sectionHeaderLabel)
        
        return sectionHeaderView
        
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFooterView = UIView()
        sectionFooterView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:50)
        sectionFooterView.backgroundColor = UIColor.clear
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:40)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        sectionHeaderLabel.backgroundColor = CustomApplicationLook.getUnderLayerColor()
            //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        sectionHeaderLabel.layer.mask = makeRoundedMask(forTop: false, bounds: sectionHeaderLabel.bounds)
        
        sectionFooterView.addSubview(sectionHeaderLabel)
        
        return sectionFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UIScreen.main.bounds.width/2
    }
 
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  50
    }
    
}

