//
//  EditClass.swift
//  StudentsApp
//
//  Created by AgentSamogon on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class EditClassController: UIViewController {
    
    private var TimesOfClassBegining = ["8:30", "10:15", "12:00", "13:50", "15:40", "17:25", "19:10"]
    private var TimesOfClassEnding = ["10:05", "11:50", "13:35", "15:25", "17:15", "19:00", "20:45"]

    @IBOutlet weak var SegmentClassType1: UISegmentedControl!
    @IBOutlet weak var SegmentClassType2: UISegmentedControl!
    
    @IBOutlet weak var SubjectField: UITextView!
    @IBOutlet weak var TeacherField: UITextField!
    @IBOutlet weak var ClassRoomField: UITextField!
    
    @IBOutlet weak var BeginTime: UITextField!
    @IBOutlet weak var EndTime: UITextField!
    
    @IBAction func ChooseEndTime(_ sender: Any) {
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        EndTime.inputView = datePicker
        datePicker.addTarget(self, action: #selector(EditClassController.ChangeEndField), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func ChooseBeginTime(_ sender: UITextField) {
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        BeginTime.inputView = datePicker
        datePicker.addTarget(self, action: #selector(EditClassController.ChangeBeginField), for: UIControlEvents.valueChanged)
    }
    
    @objc func ChangeEndField (sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH-mm"
        EndTime.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func ChangeBeginField (sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH-mm"
        BeginTime.text = dateFormatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    @IBAction func SaveButtonPressed (_ sender: Any) {
   navigationController?.popToViewController((navigationController?.viewControllers[0])!, animated: true)
    }
    
    
    @IBAction func SelectSegmentClassType1(_ sender: Any) {
        SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @IBAction func SelectSegmentClassType2(_ sender: Any) {
        SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SubjectField.backgroundColor = UIColor.lightGray
        TeacherField.backgroundColor = UIColor.lightGray
        ClassRoomField.backgroundColor = UIColor.lightGray
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.005)
        self.navigationItem.title = "Добавление"
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(EditClassController.SaveButtonPressed(_:)))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


