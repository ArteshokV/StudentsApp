//
//  MenuTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class MenuTabViewController: UIViewController {

    @IBOutlet weak var UniversitySelectedLabel: UILabel!
    @IBOutlet weak var FacultySelectedLabel: UILabel!
    @IBOutlet weak var GroupSelectedLabel: UILabel!
    
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

        let appDesign = CustomApplicationLook()
        appDesign.initBackground(ofView: self.view)
        
        
        // Do any additional setup after loading the view.
        selectedStudyPlace = getSetectedStudyPlace()
        UniversitySelectedLabel.text = selectedStudyPlace[0].name
        FacultySelectedLabel.text = selectedStudyPlace[1].name
        GroupSelectedLabel.text = selectedStudyPlace[2].name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
