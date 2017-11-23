//
//  SecondSetupViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 15.11.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class SecondSetupViewController: UIViewController {

    let appDesign = CustomApplicationLook()
    var StudyPlace: [studyUnit]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDesign.initBackground(ofView: self.view)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func enterTimetablePressed(_ sender: UIButton) {
        let initor = DataBaseInitiator()
        if(initor.databaseIsEmpty()){
            saveSelectedStudyPlace()
            self.hidesBottomBarWhenPushed = true
            self.performSegue(withIdentifier: "toEditTimetable", sender: self)
        }else{
            showAlertToDeleteData()
        }
        
    }
    
    func showAlertToDeleteData(){
        let alertController: UIAlertController = UIAlertController(title: "Вы действительно хотите продолжить?", message: "При продолжении все старые данные будут стёрты.", preferredStyle: .alert)
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Нет", style: .default) { action -> Void in
        }
        let deleteAction: UIAlertAction = UIAlertAction(title: "Да", style: .destructive) { action -> Void in
            let initor = DataBaseInitiator()
            initor.deleteDatabase()
            initor.updateViews()
            self.saveSelectedStudyPlace()
            self.hidesBottomBarWhenPushed = true
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "EditTimeTable", bundle: nil)
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChangeTimetable") as! EditTimeTableController
            homeViewController.shouldShowStartButton = true
            let nav = UINavigationController(rootViewController: homeViewController)
            appdelegate.window!.rootViewController = nav
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toEditTimetable"){
            let editVC = segue.destination as! EditTimeTableController
            editVC.shouldShowStartButton = true
            
        }
    }
    
    func saveSelectedStudyPlace(){
        do{
            let university = try JSONEncoder().encode(StudyPlace[0])
            let faculty = try JSONEncoder().encode(StudyPlace[1])
            let group = try JSONEncoder().encode(StudyPlace[2])
            UserDefaults.standard.set(university, forKey: "selectedUniversity")
            UserDefaults.standard.set(faculty, forKey: "selectedFaculty")
            UserDefaults.standard.set(group, forKey: "selectedGroup")
        }catch{
            print("Unable to encode selectedJson")
        }
    }

}
