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
    private var DateOfBeginOfSemester = CustomDateClass(withString: "01.09.2017")//дата начала семестра
    private var DateOfEndOfSemester = CustomDateClass(withString: "24.12.2017")//дата конца семестра
    private var BeginTimeInDate:CustomDateClass = CustomDateClass()
    private var EndTimeInDate:CustomDateClass = CustomDateClass()
    private var PeriodicStartDateValue:CustomDateClass = CustomDateClass()
    private var PeriodicEndDateValue:CustomDateClass = CustomDateClass()
    private var dateFormatterForTime = DateFormatter()
    private var dateFormatterForDate = DateFormatter()
    private var ChoosenDay:Int = 0
    private var WeekInterval:TimeInterval = 60*60*24*7
    private var FiveMinutesInterval: TimeInterval = 5*60
    private var OneDayInterval: TimeInterval = 60*60*24
    private var CoorForAnimation:CGFloat = 0
    private var AnimationDo:Bool = false
    private var ClassModel:TimetableModel = TimetableModel()

    

    @IBOutlet weak var RegularityCustomView: UIView!
    @IBOutlet weak var RegularityView: UIView!
    
    @IBOutlet weak var MondayButton: UIButton!
    @IBOutlet weak var TuesdayButton: UIButton!
    @IBOutlet weak var WednesdayButton: UIButton!
    @IBOutlet weak var ThursdayButton: UIButton!
    @IBOutlet weak var FridayButton: UIButton!
    @IBOutlet weak var SaturdayButton: UIButton!
    @IBOutlet weak var CreateNewDateForTableButton: UIButton!
    @IBOutlet weak var DeleteClassButton: UIButton!
    
    @IBOutlet weak var TableForDates: UITableView!
    
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
            let difference = Double(7-DateOfBeginOfSemester.weekDayInt!-(7-ChoosenDay))
            let interval = TimeInterval(OneDayInterval*sqrt(difference*difference))
            PeriodicStartDateValue = CustomDateClass(withDate: (DateOfBeginOfSemester.currentDate?.addingTimeInterval(interval))!)
            PeriodicStartDate.text = PeriodicStartDateValue.stringFromDate()
        }
        if (DayNumber == 2) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.lightGray
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            let difference = Double(7-DateOfBeginOfSemester.weekDayInt!-(7-ChoosenDay))
            let interval = TimeInterval(OneDayInterval*sqrt(difference*difference))
            PeriodicStartDateValue = CustomDateClass(withDate: (DateOfBeginOfSemester.currentDate?.addingTimeInterval(interval))!)
            PeriodicStartDate.text = PeriodicStartDateValue.stringFromDate()
        }
        if (DayNumber == 3) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.lightGray
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            let difference = Double(7-DateOfBeginOfSemester.weekDayInt!-(7-ChoosenDay))
            let interval = TimeInterval(OneDayInterval*sqrt(difference*difference))
            PeriodicStartDateValue = CustomDateClass(withDate: (DateOfBeginOfSemester.currentDate?.addingTimeInterval(interval))!)
            PeriodicStartDate.text = PeriodicStartDateValue.stringFromDate()
        }
        if (DayNumber == 4) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.lightGray
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            let difference = Double(7-DateOfBeginOfSemester.weekDayInt!-(7-ChoosenDay))
            let interval = TimeInterval(OneDayInterval*sqrt(difference*difference))
            PeriodicStartDateValue = CustomDateClass(withDate: (DateOfBeginOfSemester.currentDate?.addingTimeInterval(interval))!)
            PeriodicStartDate.text = PeriodicStartDateValue.stringFromDate()
        }
        if (DayNumber == 5) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.lightGray
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            let difference = Double(7-DateOfBeginOfSemester.weekDayInt!-(7-ChoosenDay))
            let interval = TimeInterval(OneDayInterval*sqrt(difference*difference))
            PeriodicStartDateValue = CustomDateClass(withDate: (DateOfBeginOfSemester.currentDate?.addingTimeInterval(interval))!)
            PeriodicStartDate.text = PeriodicStartDateValue.stringFromDate()
        }
        if (DayNumber == 6) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.lightGray
            ChoosenDay = DayNumber
            let difference = Double(7-DateOfBeginOfSemester.weekDayInt!-(7-ChoosenDay))
            let interval = TimeInterval(OneDayInterval*sqrt(difference*difference))
            PeriodicStartDateValue = CustomDateClass(withDate: (DateOfBeginOfSemester.currentDate?.addingTimeInterval(interval))!)
            PeriodicStartDate.text = PeriodicStartDateValue.stringFromDate()
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
            RegularityView.isHidden = false
            RegularityCustomView.isHidden = true
            
        }
        else {
            RegularityView.isHidden = true
            RegularityCustomView.isHidden = false
        }
    }
    
    @IBAction func CreateNewDateInTable(_ sender: Any) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        let doneButton:UIButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2 - 50), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        doneButton.addTarget(self, action: #selector(EditClassController.DoneButtonPressed), for: UIControlEvents.touchUpInside)
        let datePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 40, width: 0, height: 0))
        customView.addSubview(datePicker)
        customView.addSubview(doneButton)
        datePicker.datePickerMode = UIDatePickerMode.date
    }
    
    
    @IBAction func ChoosePeriodicStartDate(_ sender: Any) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        let doneButton:UIButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2 - 50), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        doneButton.addTarget(self, action: #selector(EditClassController.DoneButtonPressed), for: UIControlEvents.touchUpInside)
        let datePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 40, width: 0, height: 0))
        customView.addSubview(datePicker)
        customView.addSubview(doneButton)
        datePicker.datePickerMode = UIDatePickerMode.date
        PeriodicStartDate.inputView = customView
        PeriodicStartDate.tintColor = UIColor.clear
        if (PeriodicStartDate.text != "") {
            datePicker.setDate(PeriodicStartDateValue.currentDate!, animated: false)
        }
        if (PeriodicEndDate.text != "") {
            datePicker.maximumDate = PeriodicEndDateValue.currentDate?.addingTimeInterval(-WeekInterval)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangePeriodicStartDateField), for: UIControlEvents.valueChanged)

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.RegularityView.center.y -= customView.center.y
            self.CoorForAnimation = customView.center.y
            self.AnimationDo = true
        }, completion: nil)
    }
    
    @IBAction func ChoosePeriodicEndDate(_ sender: Any) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        let doneButton:UIButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2 - 50), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        doneButton.addTarget(self, action: #selector(EditClassController.DoneButtonPressed), for: UIControlEvents.touchUpInside)
        let datePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 40, width: 0, height: 0))
        customView.addSubview(datePicker)
        customView.addSubview(doneButton)
        datePicker.datePickerMode = UIDatePickerMode.date
        PeriodicEndDate.inputView = customView
        PeriodicEndDate.tintColor = UIColor.clear
        if (PeriodicEndDate.text != "") {
            datePicker.setDate(PeriodicEndDateValue.currentDate!, animated: false)
        }
        if (PeriodicStartDate.text != "") {
            datePicker.minimumDate = PeriodicStartDateValue.currentDate?.addingTimeInterval(WeekInterval)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangePeriodicEndDateField), for: UIControlEvents.valueChanged)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.RegularityView.center.y -= customView.center.y
            self.CoorForAnimation = customView.center.y
            self.AnimationDo = true
        }, completion: nil)
    }
    
    @IBAction func ChooseEndTime(_ sender: Any) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        let doneButton:UIButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2 - 50), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        doneButton.addTarget(self, action: #selector(EditClassController.DoneButtonPressed), for: UIControlEvents.touchUpInside)
        let datePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 40, width: 0, height: 0))
        customView.addSubview(datePicker)
        customView.addSubview(doneButton)
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.minuteInterval = 5
        EndTime.inputView = customView
        EndTime.tintColor = UIColor.clear
        if (EndTime.text != "") {
            datePicker.setDate(EndTimeInDate.currentDate!, animated: false)
        }
        if (BeginTime.text != "") {
            datePicker.minimumDate = BeginTimeInDate.currentDate?.addingTimeInterval(FiveMinutesInterval)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangeEndField), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func ChooseBeginTime(_ sender: UITextField) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        let doneButton:UIButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2 - 50), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        doneButton.addTarget(self, action: #selector(EditClassController.DoneButtonPressed), for: UIControlEvents.touchUpInside)
        let datePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 40, width: 0, height: 0))
        customView.addSubview(datePicker)
        customView.addSubview(doneButton)
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.minuteInterval = 5
        BeginTime.inputView = customView
        BeginTime.tintColor = UIColor.clear
        if (BeginTime.text != "") {
            datePicker.setDate(BeginTimeInDate.currentDate!, animated: false)
        }
        if (EndTime.text != "") {
            datePicker.maximumDate = EndTimeInDate.currentDate?.addingTimeInterval(-FiveMinutesInterval)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangeBeginField), for: UIControlEvents.valueChanged)
    }
    
    
    @IBAction func didChooseEndTime(_ sender: Any) {
        SegmentOfNumberOfClass.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @IBAction func didChooseBeginTime(_ sender: Any) {
        SegmentOfNumberOfClass.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @objc func DoneButtonPressed (sender:UIButton) {
        view.endEditing(true)
        if (AnimationDo) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.RegularityView.center.y += self.CoorForAnimation
                self.CoorForAnimation = 0
                self.AnimationDo = false
            }, completion: nil)
        }
    }
    
    @objc func ChangePeriodicStartDateField (sender:UIDatePicker) {
        PeriodicStartDateValue.currentDate = sender.date
        PeriodicStartDate.text = dateFormatterForDate.string(from: sender.date)
    }
    
    @objc func ChangePeriodicEndDateField (sender:UIDatePicker) {
        PeriodicEndDateValue.currentDate = sender.date
        PeriodicEndDate.text = dateFormatterForDate.string(from: sender.date)
    }
    
    @objc func ChangeEndField (sender:UIDatePicker) {
        EndTimeInDate.currentDate = sender.date
        EndTime.text = dateFormatterForTime.string(from: sender.date)
    }
    
    @objc func ChangeBeginField (sender:UIDatePicker) {
        BeginTimeInDate.currentDate = sender.date
        BeginTime.text = dateFormatterForTime.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
        if (AnimationDo) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.RegularityView.center.y += self.CoorForAnimation
                self.CoorForAnimation = 0
                self.AnimationDo = false
            }, completion: nil)
        }
    }
    
    @IBAction func SaveButtonPressed (_ sender: Any) {
        (navigationController?.viewControllers[1] as! EditTimeTableController).GetClass(GetterClass: ComplectClassInformation(ComplectClass: ClassModel))
        (navigationController?.viewControllers[1] as! EditTimeTableController).TableOfClasses.reloadData()
        navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
    }
    
    @IBAction func NumberOfClassChoice(_ sender: Any) {
        BeginTime.text = TimesOfClassBegining[SegmentOfNumberOfClass.selectedSegmentIndex]
        BeginTimeInDate.currentDate = dateFormatterForTime.date(from: TimesOfClassBegining[SegmentOfNumberOfClass.selectedSegmentIndex])
        EndTime.text = TimesOfClassEnding[SegmentOfNumberOfClass.selectedSegmentIndex]
        EndTimeInDate.currentDate = dateFormatterForTime.date(from: TimesOfClassEnding[SegmentOfNumberOfClass.selectedSegmentIndex])
    }
    
    @IBAction func SelectSegmentClassType1(_ sender: Any) {
        SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @IBAction func SelectSegmentClassType2(_ sender: Any) {
        SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    func ComplectClassInformation (ComplectClass: TimetableModel) -> TimetableModel {
        ComplectClass.classBeginDate = PeriodicStartDateValue
        ComplectClass.classEndDate = PeriodicEndDateValue
        ComplectClass.classEndTime = EndTime.text
        ComplectClass.classStartTime = BeginTime.text
        ComplectClass.classPlace = ClassRoomField.text
        ComplectClass.classSubject = SubjectField.text
        let tech:TeacherModel = TeacherModel()
        tech.familyName = TeacherField.text
        tech.fatherName = TeacherField.text
        tech.name = TeacherField.text
        ComplectClass.classTeacher = tech
        ComplectClass.classType = SegmentClassType1.titleForSegment(at: SegmentClassType1.selectedSegmentIndex)
        ComplectClass.classDate = CustomDateClass(withDate: (dateFormatterForDate.date(from: "01.09.2017")!).addingTimeInterval(TimeInterval(60*60*24*(ChoosenDay))))
        return ComplectClass
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatterForTime.dateFormat = "HH:mm"
        dateFormatterForDate.dateFormat = "dd.MM.yyyy"
        
        SubjectField.backgroundColor = UIColor.lightGray
        TeacherField.backgroundColor = UIColor.lightGray
        ClassRoomField.backgroundColor = UIColor.lightGray
        
        RegularityCustomView.isHidden = true
        
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


