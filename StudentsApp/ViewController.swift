//
//  ViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 05.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var someLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        //let taskObject: TimetableModel = TimetableModel()
        let test: Int = TimetableModel.getTimetable().count
        // Do any additional setup after loading the view, typically from a nib.
        someLabel?.text = "NUMBER \(test)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

