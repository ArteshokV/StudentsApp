//
//  SecondSetupViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 15.11.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class SecondSetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func enterTimetablePressed(_ sender: UIButton) {
        let initor = DataBaseInitiator()
        initor.deleteDatabase()
        initor.updateViews()
        self.hidesBottomBarWhenPushed = true
        self.performSegue(withIdentifier: "toEditTimetable", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toEditTimetable"){
            let editVC = segue.destination as! EditTimeTableController
            editVC.shouldShowStartButton = true
            
        }
    }

}
