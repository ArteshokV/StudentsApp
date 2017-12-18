//
//  MenuTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import MessageUI

class MenuTabViewController: UIViewController , MFMailComposeViewControllerDelegate {

    
    @IBOutlet var HeaderLabels: [UILabel]!
    @IBOutlet weak var underLayerView: UIView!
    
    @IBOutlet weak var UniversitySelectedLabel: UILabel!
    @IBOutlet weak var FacultySelectedLabel: UILabel!
    @IBOutlet weak var GroupSelectedLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var changeStudyPlace: UIButton!
    @IBOutlet weak var registerChangeButton: UIButton!
    @IBOutlet weak var SyncButton: UIButton!
    
    @IBOutlet weak var connectWithDevelopersButton: UIButton!
    @IBOutlet weak var changeAppDesignButton: UIButton!
    
    let appDesign = CustomApplicationLook()
    
    var selectedStudyPlace: Array<studyUnit>!
    
    func getSetectedStudyPlace() -> Array<studyUnit>{
        //Get selected items into UserDefaults
        do{
            let selectedUniversity = try JSONDecoder().decode(studyUnit.self, from: UserDefaults.standard.data(forKey: "selectedUniversity")!)
            let selectedFaculty = try JSONDecoder().decode(studyUnit.self, from: UserDefaults.standard.data(forKey: "selectedFaculty")!)
            let selectedGroup = try JSONDecoder().decode(studyUnit.self, from: UserDefaults.standard.data(forKey: "selectedGroup")!)
            //print([selectedUniversity, selectedFaculty, selectedGroup])
            return [selectedUniversity, selectedFaculty, selectedGroup]
        }catch{
            print("Unable to decode selectedJson")
        }
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDesign.initBackground(ofView: self.view)
        
        underLayerView.backgroundColor = appDesign.underLayerColor
        underLayerView.layer.cornerRadius = 15.0
        appDesign.managedLayersContext.append(underLayerView)
        
        for label in HeaderLabels{
            label.textColor = appDesign.mainTextColor
            appDesign.managedMainLablesContext.append(label)
        }
        
        navigationController?.navigationBar.barTintColor = UIColor.darkGray//appDesign.underLayerColor
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: appDesign.mainTextColor]
        //self.preferredStatusBarStyle = .lightContent
        
        UniversitySelectedLabel.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(UniversitySelectedLabel)
        FacultySelectedLabel.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(FacultySelectedLabel)
        GroupSelectedLabel.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(GroupSelectedLabel)
        userName.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(userName)
        
        
        connectWithDevelopersButton.setTitleColor(appDesign.mainTextColor, for: .normal)
        appDesign.managedMainButonsContext.append(connectWithDevelopersButton)
        connectWithDevelopersButton.backgroundColor = appDesign.underLayerColor
        //changeTimetableButton.layer.cornerRadius = 15.0
        appDesign.managedLayersContext.append(connectWithDevelopersButton)
        
        changeAppDesignButton.setTitleColor(appDesign.mainTextColor, for: .normal)
        appDesign.managedMainButonsContext.append(changeAppDesignButton)
        changeAppDesignButton.backgroundColor = appDesign.underLayerColor
        //changeAppDesignButton.layer.cornerRadius = 15.0
        appDesign.managedLayersContext.append(changeAppDesignButton)
        
        changeStudyPlace.setTitleColor(appDesign.mainTextColor, for: .normal)
        appDesign.managedMainButonsContext.append(changeStudyPlace)
        changeStudyPlace.backgroundColor = appDesign.underLayerColor
        changeStudyPlace.layer.cornerRadius = 15.0
        appDesign.managedLayersContext.append(changeStudyPlace)
        
        registerChangeButton.setTitleColor(appDesign.mainTextColor, for: .normal)
        appDesign.managedMainButonsContext.append(registerChangeButton)
        registerChangeButton.backgroundColor = appDesign.underLayerColor
        registerChangeButton.layer.cornerRadius = 15.0
        appDesign.managedLayersContext.append(registerChangeButton)
        
        SyncButton.setTitleColor(appDesign.mainTextColor, for: .normal)
        appDesign.managedMainButonsContext.append(SyncButton)
        SyncButton.backgroundColor = appDesign.underLayerColor
        //SyncButton.layer.cornerRadius = 15.0
        appDesign.managedLayersContext.append(SyncButton)
        
        //userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.borderWidth = 0.5
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        // Do any additional setup after loading the view.
        selectedStudyPlace = getSetectedStudyPlace()
        UniversitySelectedLabel.text = selectedStudyPlace[0].name
        FacultySelectedLabel.text = selectedStudyPlace[1].name
        GroupSelectedLabel.text = selectedStudyPlace[2].name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(!(self.navigationController?.navigationBar.isHidden)!){
            //self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        super.viewWillAppear(animated)
        setUpNavigationBars()
        
        selectedStudyPlace = getSetectedStudyPlace()
        UniversitySelectedLabel.text = selectedStudyPlace[0].name
        FacultySelectedLabel.text = selectedStudyPlace[1].name
        GroupSelectedLabel.text = selectedStudyPlace[2].name
    }
    
    func setUpNavigationBars(){
        let barsColor = appDesign.tabBarColor.withAlphaComponent(1)
        self.navigationController?.navigationBar.barTintColor = barsColor
        self.navigationController?.navigationBar.tintColor = appDesign.subTextColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: appDesign.mainTextColor]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.height / 2 - 1
    }

    @IBAction func connectWithDevelopersPressed(_ sender: Any) { //выбор просмотра заданий
        self.hidesBottomBarWhenPushed = true
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["vlad@zakharov.com"])
            mail.setMessageBody("<p>Здравствуйте! хочу обратиться к вам:</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
            let alertController = UIAlertController(title: "Ошибка", message:
                "Почта недоступна!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        //self.performSegue(withIdentifier: "fromMenuToEditTimetable", sender: self)
        self.hidesBottomBarWhenPushed = false
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func changeStudyPlacePressed(_ sender: UIButton) {
        self.hidesBottomBarWhenPushed = true
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginScreen") as! StudyPlaceSelectionViewController
        vc.wasPushedFromMenu = true
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func chooseAppDesignPressed(_ sender: UIButton) {
        self.hidesBottomBarWhenPushed = true
        self.performSegue(withIdentifier: "changeAppDesign", sender: self)
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func enterProfileButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Войти", message:
            "Здесь будет регистрация!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func SyncButtonPressed(_ sender: UIButton) {
        let query = NetworkClass()
        query.getInitilData(forUniversity: selectedStudyPlace[0].id, forFaculty: selectedStudyPlace[1].id, forGroup: selectedStudyPlace[2].id, withCompletition: {(response) in
            var alertTitleText = ""
            var alertMessageText = ""
            if(response != nil){
                let dbInitor = DataBaseInitiator()
                dbInitor.insertInitialData(withParsedStruct: response)
                alertTitleText = "Готово"
                alertMessageText = "Синхронизация прошла успешно!"
            }else{
                alertTitleText = "Ошибка"
                alertMessageText = "Произошла ошибка при синхронизации, попробуйте позже!"
            }
            
            let alertController = UIAlertController(title: alertTitleText, message:
                alertMessageText, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
}
