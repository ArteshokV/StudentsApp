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
    private var BeginTimeInDate:CustomDateClass = CustomDateClass()
    private var EndTimeInDate:CustomDateClass = CustomDateClass()
    private var dateFormatter = DateFormatter()
    private var ChoosenDay:Int = 0

    @IBOutlet weak var MondayButton: UIButton!
    @IBOutlet weak var TuesdayButton: UIButton!
    @IBOutlet weak var WednesdayButton: UIButton!
    @IBOutlet weak var ThursdayButton: UIButton!
    @IBOutlet weak var FridayButton: UIButton!
    @IBOutlet weak var SaturdayButton: UIButton!
    
    
    @IBOutlet weak var PeriodicSegment: UISegmentedControl!
    @IBOutlet weak var RegularitySegment: UISegmentedControl!
    @IBOutlet weak var SegmentClassType1: UISegmentedControl!
    @IBOutlet weak var SegmentClassType2: UISegmentedControl!
    @IBOutlet weak var SegmentOfNumberOfClass: UISegmentedControl!
    
    @IBOutlet weak var SubjectField: UITextView!
    @IBOutlet weak var TeacherField: UITextField!
    @IBOutlet weak var ClassRoomField: UITextField!
    @IBOutlet weak var PeriodicStartDate: UITextField!
    @IBOutlet weak var PeriodicEndDate: UITextField!
    @IBOutlet weak var BeginTime: UITextField!
    @IBOutlet weak var EndTime: UITextField!
    
    @IBOutlet weak var PeriodicStartDateLabel: UILabel!
    @IBOutlet weak var PeriodicEndDateLabel: UILabel!
    
    func ChooseDay (DayNumber: Int) {
        if (DayNumber == 1) {
            MondayButton.backgroundColor = UIColor.lightGray
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
        }
        if (DayNumber == 2) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.lightGray
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
        }
        if (DayNumber == 3) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.lightGray
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
        }
        if (DayNumber == 4) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.lightGray
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
        }
        if (DayNumber == 5) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.lightGray
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
        }
        if (DayNumber == 6) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.lightGray
            ChoosenDay = DayNumber
        }
    }
    
    @IBAction func ChooseMonday(_ sender: Any) {
        ChooseDay(DayNumber: 1)
    }
    @IBAction func ChooseThusday(_ sender: Any) {
        ChooseDay(DayNumber: 2)
    }
    @IBAction func ChooseWensday(_ sender: Any) {
        ChooseDay(DayNumber: 3)
    }
    @IBAction func ChooseThursday(_ sender: Any) {
        ChooseDay(DayNumber: 4)
    }
    @IBAction func ChooseFriday(_ sender: Any) {
        ChooseDay(DayNumber: 5)
    }
    @IBAction func ChooseSaturday(_ sender: Any) {
        ChooseDay(DayNumber: 6)
    }
    
    @IBAction func ChooseRegularity(_ sender: Any) {
        if (RegularitySegment.selectedSegmentIndex == 0) {
            MondayButton.isHidden = false
            TuesdayButton.isHidden = false
            WednesdayButton.isHidden = false
            ThursdayButton.isHidden = false
            FridayButton.isHidden = false
            SaturdayButton.isHidden = false
            PeriodicSegment.isHidden = false
            PeriodicEndDate.isHidden = false
            PeriodicStartDate.isHidden = false
            PeriodicStartDateLabel.isHidden = false
            PeriodicEndDateLabel.isHidden = false
        }
        else {
            MondayButton.isHidden = true
            TuesdayButton.isHidden = true
            WednesdayButton.isHidden = true
            ThursdayButton.isHidden = true
            FridayButton.isHidden = true
            SaturdayButton.isHidden = true
            PeriodicSegment.isHidden = true
            PeriodicEndDate.isHidden = true
            PeriodicStartDate.isHidden = true
            PeriodicStartDateLabel.isHidden = true
            PeriodicEndDateLabel.isHidden = true
        }
    }
    
    
    @IBAction func ChooseEndTime(_ sender: Any) {
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.minuteInterval = 5
        EndTime.inputView = datePicker
        EndTime.tintColor = UIColor.clear
        if (EndTime.text != "") {
            datePicker.setDate(EndTimeInDate.currentDate!, animated: false)
        }
        if (BeginTime.text != "") {
            datePicker.minimumDate = BeginTimeInDate.currentDate?.addingTimeInterval(60*5)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangeEndField), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func ChooseBeginTime(_ sender: UITextField) {
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.minuteInterval = 5
        BeginTime.inputView = datePicker
        BeginTime.tintColor = UIColor.clear
        if (BeginTime.text != "") {
            datePicker.setDate(BeginTimeInDate.currentDate!, animated: false)
        }
        if (EndTime.text != "") {
            datePicker.maximumDate = EndTimeInDate.currentDate?.addingTimeInterval(-60*5)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangeBeginField), for: UIControlEvents.valueChanged)
    }
    
    
    @IBAction func didChooseEndTime(_ sender: Any) {
        SegmentOfNumberOfClass.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @IBAction func didChooseBeginTime(_ sender: Any) {
        SegmentOfNumberOfClass.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @objc func ChangeEndField (sender:UIDatePicker) {
        EndTimeInDate.currentDate = sender.date
        EndTime.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func ChangeBeginField (sender:UIDatePicker) {
        BeginTimeInDate.currentDate = sender.date
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
    
    @IBAction func NumberOfClassChoice(_ sender: Any) {
        BeginTime.text = TimesOfClassBegining[SegmentOfNumberOfClass.selectedSegmentIndex]
        BeginTimeInDate.currentDate = dateFormatter.date(from: TimesOfClassBegining[SegmentOfNumberOfClass.selectedSegmentIndex])
        EndTime.text = TimesOfClassEnding[SegmentOfNumberOfClass.selectedSegmentIndex]
        EndTimeInDate.currentDate = dateFormatter.date(from: TimesOfClassEnding[SegmentOfNumberOfClass.selectedSegmentIndex])
    }
    
    @IBAction func SelectSegmentClassType1(_ sender: Any) {
        SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @IBAction func SelectSegmentClassType2(_ sender: Any) {
        SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "HH:mm"
        
        SubjectField.backgroundColor = UIColor.lightGray
        TeacherField.backgroundColor = UIColor.lightGray
        ClassRoomField.backgroundColor = UIColor.lightGray
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.005)
        self.navigationItem.title = "Добавление"
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(EditClassController.SaveButtonPressed(_:)))
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


