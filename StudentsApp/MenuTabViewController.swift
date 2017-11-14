//
//  MenuTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class MenuTabViewController: UIViewController {

    
    @IBOutlet var HeaderLabels: [UILabel]!
    @IBOutlet weak var underLayerView: UIView!
    
    @IBOutlet weak var UniversitySelectedLabel: UILabel!
    @IBOutlet weak var FacultySelectedLabel: UILabel!
    @IBOutlet weak var GroupSelectedLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var changeStudyPlace: UIButton!
    @IBOutlet weak var registerChangeButton: UIButton!
    
    @IBOutlet weak var changeTimetableButton: UIButton!
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
        UniversitySelectedLabel.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(UniversitySelectedLabel)
        FacultySelectedLabel.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(FacultySelectedLabel)
        GroupSelectedLabel.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(GroupSelectedLabel)
        userName.textColor = appDesign.subTextColor
        appDesign.managedSubLablesContext.append(userName)
        
        
        changeTimetableButton.setTitleColor(appDesign.mainTextColor, for: .normal)
        appDesign.managedMainButonsContext.append(changeTimetableButton)
        changeTimetableButton.backgroundColor = appDesign.underLayerColor
        //changeTimetableButton.layer.cornerRadius = 15.0
        appDesign.managedLayersContext.append(changeTimetableButton)
        
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
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        super.viewWillAppear(animated)
        
        selectedStudyPlace = getSetectedStudyPlace()
        UniversitySelectedLabel.text = selectedStudyPlace[0].name
        FacultySelectedLabel.text = selectedStudyPlace[1].name
        GroupSelectedLabel.text = selectedStudyPlace[2].name
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.height / 2 - 1
    }

    @IBAction func changeTimetableButtonPressed(_ sender: Any) { //выбор просмотра заданий
        self.hidesBottomBarWhenPushed = true
        self.performSegue(withIdentifier: "fromMenuToEditTimetable", sender: self)
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func changeStudyPlacePressed(_ sender: UIButton) {
        self.hidesBottomBarWhenPushed = true
        self.performSegue(withIdentifier: "changeStudyPlace", sender: self)
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
    
}
