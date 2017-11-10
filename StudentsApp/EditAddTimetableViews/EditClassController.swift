//
//  EditClass.swift
//  StudentsApp
//
//  Created by AgentSamogon on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class EditClassController: UIViewController {
    
    private var TimesOfClassBegining = ["08:30", "10:15", "12:00", "13:50", "15:40", "17:25", "19:10"]
    private var TimesOfClassEnding = ["10:05", "11:50", "13:35", "15:25", "17:15", "19:00", "20:45"]
    private var DateOfBeginOfSemester = CustomDateClass(withString: "01.09.2017")//дата начала семестра
    private var DateOfEndOfSemester = CustomDateClass(withString: "24.12.2017")//дата конца семестра
    private var BeginTimeInDate: CustomDateClass = CustomDateClass()
    private var EndTimeInDate: CustomDateClass = CustomDateClass()
    private var PeriodicStartDateValue: CustomDateClass = CustomDateClass()
    private var PeriodicEndDateValue: CustomDateClass = CustomDateClass()
    private var dateFormatterForTime = DateFormatter()
    private var dateFormatterForDate = DateFormatter()
    private var ChoosenDay: Int = 0
    private var ChoosenClassType: String = "Лекция"
    private var ChoosenParity: Bool?
    private var WeekInterval: TimeInterval = 60*60*24*7
    private var FiveMinutesInterval: TimeInterval = 5*60
    private var OneDayInterval: TimeInterval = 60*60*24
    private var CoorForAnimation:CGFloat = 0
    private var AnimationDo: Bool = false
    private var ClassTempModel: TimetableModel = TimetableModel()
    private var SubjectTempModel: SubjectModel = SubjectModel()
    private var TeacherTempModel: TeacherModel = TeacherModel()
    private var SubjectHelpArray: Array<SubjectModel> = SubjectModel.getSubjects()
    private var TeacherHelpArray: Array<TeacherModel> = TeacherModel.getTeachers()
    private var ArrayOfCustomDates: Array<CustomDateClass> = Array()
    private var CustomClassTypeButtonMode: Bool = false
    private var CustomDateMode: Bool = false


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
    @IBOutlet weak var CustomClassTypeButton: UIButton!
    
    @IBOutlet weak var TableForDates: UITableView!
    
    @IBOutlet weak var ParitySegment: UISegmentedControl!
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
            PeriodicStartDateValue = DateOfBeginOfSemester
            PeriodicEndDateValue = DateOfEndOfSemester
            PeriodicStartDate.text = DateOfBeginOfSemester.stringFromDate()
            PeriodicEndDate.text = DateOfEndOfSemester.stringFromDate()
        }
        if (DayNumber == 2) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.lightGray
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            PeriodicStartDateValue = DateOfBeginOfSemester
            PeriodicEndDateValue = DateOfEndOfSemester
            PeriodicStartDate.text = DateOfBeginOfSemester.stringFromDate()
            PeriodicEndDate.text = DateOfEndOfSemester.stringFromDate()
        }
        if (DayNumber == 3) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.lightGray
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            PeriodicStartDateValue = DateOfBeginOfSemester
            PeriodicEndDateValue = DateOfEndOfSemester
            PeriodicStartDate.text = DateOfBeginOfSemester.stringFromDate()
            PeriodicEndDate.text = DateOfEndOfSemester.stringFromDate()
        }
        if (DayNumber == 4) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.lightGray
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            PeriodicStartDateValue = DateOfBeginOfSemester
            PeriodicEndDateValue = DateOfEndOfSemester
            PeriodicStartDate.text = DateOfBeginOfSemester.stringFromDate()
            PeriodicEndDate.text = DateOfEndOfSemester.stringFromDate()
        }
        if (DayNumber == 5) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.lightGray
            SaturdayButton.backgroundColor = UIColor.white
            ChoosenDay = DayNumber
            PeriodicStartDateValue = DateOfBeginOfSemester
            PeriodicEndDateValue = DateOfEndOfSemester
            PeriodicStartDate.text = DateOfBeginOfSemester.stringFromDate()
            PeriodicEndDate.text = DateOfEndOfSemester.stringFromDate()
        }
        if (DayNumber == 6) {
            MondayButton.backgroundColor = UIColor.white
            TuesdayButton.backgroundColor = UIColor.white
            WednesdayButton.backgroundColor = UIColor.white
            ThursdayButton.backgroundColor = UIColor.white
            FridayButton.backgroundColor = UIColor.white
            SaturdayButton.backgroundColor = UIColor.lightGray
            ChoosenDay = DayNumber
            PeriodicStartDateValue = DateOfBeginOfSemester
            PeriodicEndDateValue = DateOfEndOfSemester
            PeriodicStartDate.text = DateOfBeginOfSemester.stringFromDate()
            PeriodicEndDate.text = DateOfEndOfSemester.stringFromDate()
        }
    }
    @IBAction func ChooseCustomClassType(_ sender: Any) {
        SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
        SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
        CustomClassTypeButton.backgroundColor = UIColor.blue
        CustomClassTypeButton.setTitleColor(UIColor.white, for: .normal)
        CustomClassTypeButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        CustomClassTypeButtonMode = true
        ChoosenClassType = (CustomClassTypeButton.titleLabel?.text)!
        CheckSaveButton()
    }
    
    @IBAction func ChooseMonday(_ sender: Any) {
        ChooseDay(DayNumber: 1)
        CheckSaveButton()
    }
    @IBAction func ChooseThusday(_ sender: Any) {
        ChooseDay(DayNumber: 2)
        CheckSaveButton()
    }
    @IBAction func ChooseWensday(_ sender: Any) {
        ChooseDay(DayNumber: 3)
        CheckSaveButton()
    }
    @IBAction func ChooseThursday(_ sender: Any) {
        ChooseDay(DayNumber: 4)
        CheckSaveButton()
    }
    @IBAction func ChooseFriday(_ sender: Any) {
        ChooseDay(DayNumber: 5)
        CheckSaveButton()
    }
    @IBAction func ChooseSaturday(_ sender: Any) {
        ChooseDay(DayNumber: 6)
        CheckSaveButton()
    }
    
    @IBAction func ChooseParity(_ sender: Any) {
        if (ParitySegment.selectedSegmentIndex == 0) {
            ChoosenParity = nil
        }
        if (ParitySegment.selectedSegmentIndex == 1) {
            ChoosenParity = false
        }
        if (ParitySegment.selectedSegmentIndex == 2) {
            ChoosenParity = true
        }
    }
    
    
    @IBAction func ChooseRegularity(_ sender: Any) {
        if (RegularitySegment.selectedSegmentIndex == 0) {
            RegularityView.isHidden = false
            RegularityCustomView.isHidden = true
            CustomDateMode = false
        }
        else {
            RegularityView.isHidden = true
            RegularityCustomView.isHidden = false
            CustomDateMode = true
        }
        CheckSaveButton()
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
    
    //////////////////////////////////////////////////////////////////////ДАТА ПИКЕРЫ
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
        datePicker.minimumDate = DateOfBeginOfSemester.currentDate
        if (PeriodicStartDate.text != "") {
            datePicker.setDate(PeriodicStartDateValue.currentDate!, animated: false)
        }
        if (PeriodicEndDate.text != "") {
            datePicker.maximumDate = PeriodicEndDateValue.currentDate?.addingTimeInterval(-WeekInterval)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangePeriodicStartDateField), for: UIControlEvents.valueChanged)
        if (!AnimationDo) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.CoorForAnimation = customView.frame.height - (self.view.frame.height - self.RegularityView.center.y - self.RegularityView.frame.height/2)
                self.RegularityView.center.y -= self.CoorForAnimation
                self.AnimationDo = true
            }, completion: nil)
        }
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
        datePicker.maximumDate = DateOfEndOfSemester.currentDate
        if (PeriodicEndDate.text != "") {
            datePicker.setDate(PeriodicEndDateValue.currentDate!, animated: false)
        }
        if (PeriodicStartDate.text != "") {
            datePicker.minimumDate = PeriodicStartDateValue.currentDate?.addingTimeInterval(WeekInterval)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangePeriodicEndDateField), for: UIControlEvents.valueChanged)
        if (!AnimationDo) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.CoorForAnimation = customView.frame.height - (self.view.frame.height - self.RegularityView.center.y - self.RegularityView.frame.height/2)
                self.RegularityView.center.y -= self.CoorForAnimation
                self.AnimationDo = true
            }, completion: nil)
        }
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
        if (BeginTime.text != "") {
            datePicker.minimumDate = BeginTimeInDate.currentDate?.addingTimeInterval(FiveMinutesInterval)
            if (EndTime.text == "") {
                EndTimeInDate.currentDate = BeginTimeInDate.currentDate?.addingTimeInterval(5*60)
                EndTime.text = dateFormatterForTime.string(from: EndTimeInDate.currentDate!)
            }
        }
        if (EndTime.text != "") {
            datePicker.setDate(EndTimeInDate.currentDate!, animated: false)
        }
        else {
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: EndTimeInDate.currentDate!)
            EndTimeInDate.currentDate = EndTimeInDate.currentDate?.addingTimeInterval(TimeInterval(-(min%5 * 60)))
            EndTime.text = dateFormatterForTime.string(from: (EndTimeInDate.currentDate)!)
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
        if (EndTime.text != "") {
            datePicker.maximumDate = EndTimeInDate.currentDate?.addingTimeInterval(-FiveMinutesInterval)
            if (BeginTime.text == "") {
                BeginTimeInDate.currentDate = EndTimeInDate.currentDate?.addingTimeInterval(-5*60)
                BeginTime.text = dateFormatterForTime.string(from: BeginTimeInDate.currentDate!)
            }
        }
        if (BeginTime.text != "") {
            datePicker.setDate(BeginTimeInDate.currentDate!, animated: false)
        }
        else {
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: BeginTimeInDate.currentDate!)
            BeginTimeInDate.currentDate = BeginTimeInDate.currentDate?.addingTimeInterval(TimeInterval(-(min%5 * 60)))
            BeginTime.text = dateFormatterForTime.string(from: (BeginTimeInDate.currentDate)!)
        }
        datePicker.addTarget(self, action: #selector(EditClassController.ChangeBeginField), for: UIControlEvents.valueChanged)
    }
    
    
    @IBAction func didChooseEndTime(_ sender: Any) {
        SegmentOfNumberOfClass.selectedSegmentIndex = UISegmentedControlNoSegment
        CheckSaveButton()
    }
    
    @IBAction func didChooseBeginTime(_ sender: Any) {
        SegmentOfNumberOfClass.selectedSegmentIndex = UISegmentedControlNoSegment
        CheckSaveButton()
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
    
    //////////////////////////////////////////////////////////////////////ОБРАБОТКА КАСАНИЙ
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
    
    //////////////////////////////////////////////////////////////////////КНОПКА СОХРАНИТЬ
    @IBAction func SaveButtonPressed (_ sender: Any) {
        ComplectInformation()
        ClassTempModel.save()
        //SubjectTempModel.save()
        //TeacherTempModel.save()
        navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
    }
    
    @IBAction func NumberOfClassChoice(_ sender: Any) {
        BeginTime.text = TimesOfClassBegining[SegmentOfNumberOfClass.selectedSegmentIndex]
        BeginTimeInDate.currentDate = dateFormatterForTime.date(from: TimesOfClassBegining[SegmentOfNumberOfClass.selectedSegmentIndex])
        EndTime.text = TimesOfClassEnding[SegmentOfNumberOfClass.selectedSegmentIndex]
        EndTimeInDate.currentDate = dateFormatterForTime.date(from: TimesOfClassEnding[SegmentOfNumberOfClass.selectedSegmentIndex])
        CheckSaveButton()
    }
    
    @IBAction func SelectSegmentClassType1(_ sender: Any) {
        SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
        CustomClassTypeButton.backgroundColor = UIColor.white
        CustomClassTypeButton.setTitleColor(UIColor.blue, for: .normal)
        CustomClassTypeButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        CustomClassTypeButtonMode = false
        if (SegmentClassType1.selectedSegmentIndex == 0) {
            ChoosenClassType = SegmentClassType1.titleForSegment(at: 0)!
        }
        else {
            ChoosenClassType = SegmentClassType1.titleForSegment(at: 1)!
        }
        CheckSaveButton()
    }
    
    @IBAction func SelectSegmentClassType2(_ sender: Any) {
        SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
        CustomClassTypeButton.backgroundColor = UIColor.white
        CustomClassTypeButton.setTitleColor(UIColor.blue, for: .normal)
        CustomClassTypeButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        CustomClassTypeButtonMode = false
        if (SegmentClassType2.selectedSegmentIndex == 0) {
            ChoosenClassType = SegmentClassType2.titleForSegment(at: 0)!
        }
        else {
            ChoosenClassType = SegmentClassType2.titleForSegment(at: 1)!
        }
        CheckSaveButton()
    }
    
    //////////////////////////////////////////////////////////////////////КОМПЛЕКТАЦИЯ ДАННЫХ
    func ComplectInformation () {
        ClassTempModel.classPlace = ClassRoomField.text
        SubjectTempModel.subjectName = SubjectField.text
        ClassTempModel.classSubject = SubjectField.text
        TeacherTempModel.name = TeacherField.text
        TeacherTempModel.familyName = TeacherField.text
        TeacherTempModel.fatherName = TeacherField.text
        ClassTempModel.classTeacher = TeacherTempModel
        ClassTempModel.classType = ChoosenClassType
        ClassTempModel.classEndTime = EndTime.text
        ClassTempModel.classStartTime = BeginTime.text
        ClassTempModel.classWeekDay = Int16(ChoosenDay)
        ClassTempModel.parity = ChoosenParity
        ClassTempModel.classBeginDate = PeriodicStartDateValue
        ClassTempModel.classEndDate = PeriodicEndDateValue
        if (CustomDateMode) {
            ClassTempModel.classDate = nil
        }
        else {
            ClassTempModel.classDate = nil
        }
    }
    
    func CheckSaveButton () {
        if (SubjectField.text != "")&&(TeacherField.text != "")&&(ClassRoomField.text != "")&&((SegmentClassType2.selectedSegmentIndex != UISegmentedControlNoSegment)||(SegmentClassType1.selectedSegmentIndex != UISegmentedControlNoSegment)||CustomClassTypeButtonMode)&&(BeginTime.text != "")&&(EndTime.text != "")&&(((RegularitySegment.selectedSegmentIndex == 0)&&(ChoosenDay != 0))||((RegularitySegment.selectedSegmentIndex == 1)&&(ArrayOfCustomDates.count != 0))) {
            self.navigationItem.rightBarButtonItems?.first?.isEnabled = true
        }
        else {
            self.navigationItem.rightBarButtonItems?.first?.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatterForTime.dateFormat = "HH:mm"
        dateFormatterForDate.dateFormat = "dd.MM.yyyy"
        
        RegularityCustomView.isHidden = true
        
        EndTime.placeholder = "Конец"
        BeginTime.placeholder = "Начало"
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.005)
        self.navigationItem.title = "Добавление"
        let rightEditBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(EditClassController.SaveButtonPressed(_:)))
        rightEditBarButtonItem.isEnabled = false
        self.navigationItem.setRightBarButtonItems([rightEditBarButtonItem], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


