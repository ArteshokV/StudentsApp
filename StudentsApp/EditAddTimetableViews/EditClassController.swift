//
//  EditClass.swift
//  StudentsApp
//
//  Created by AgentSamogon on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class EditClassController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Переменные
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
    private var ChoosenClassType: String?
    private var ChoosenParity: Bool?
    private var WeekInterval: TimeInterval = 60*60*24*7
    private var FiveMinutesInterval: TimeInterval = 5*60
    private var OneDayInterval: TimeInterval = 60*60*24
    private var CoorForAnimation:CGFloat = 0
    private var AnimationDo: Bool = false
    var ClassTempModel: TimetableModel! //= TimetableModel()
    private var SubjectTempModel: SubjectModel = SubjectModel()
    private var TeacherTempModel: TeacherModel = TeacherModel()
    private var SubjectHelpArray: Array<SubjectModel> = SubjectModel.getSubjects()
    private var TeacherHelpArray: Array<TeacherModel> = TeacherModel.getTeachers()
    private var CustomDateInTable: CustomDateClass = CustomDateClass()
    private var ArrayOfCustomDates: Array<CustomDateClass> = Array()
    private var CustomClassTypeButtonMode: Bool = false
    private var CustomDateMode: Bool = false
    private var customViewForDatePicker = UIView()
    private var doneButtonInSubview = UIButton()
    private var datePickerInSubview = UIDatePicker()

    @IBOutlet weak var ScrollView: UIScrollView!
    
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
    
    // MARK: - Функции
    
    func ComplectDatePickerView () {
        customViewForDatePicker = UIView(frame: CGRect(x: 0, y: self.view.frame.height - 240, width: self.view.frame.width, height: 240))
        customViewForDatePicker.backgroundColor = UIColor.lightGray
        doneButtonInSubview = UIButton(frame: CGRect(x: (self.view.frame.size.width/2 - 50), y: 0, width: 100, height: 50))
        doneButtonInSubview.setTitle("Done", for: UIControlState.normal)
        doneButtonInSubview.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButtonInSubview.setTitle("Done", for: UIControlState.highlighted)
        doneButtonInSubview.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        doneButtonInSubview.addTarget(self, action: #selector(EditClassController.DoneButtonPressed), for: UIControlEvents.touchUpInside)
        datePickerInSubview = UIDatePicker(frame: CGRect(x: (self.view.frame.size.width/2 - 160), y: 40, width: 0, height: 0))
        customViewForDatePicker.addSubview(datePickerInSubview)
        customViewForDatePicker.addSubview(doneButtonInSubview)
    }
    
    func CheckDateInTable (DateForCheck: CustomDateClass) -> Bool {
        if (ArrayOfCustomDates.count != 0) {
            for CustomDate in ArrayOfCustomDates {
                if (CustomDate == DateForCheck) {
                    return false
                }
            }
            return true
        }
        else {
            return true
        }
    }
    
    func ChooseDay (DayNumber: Int) {
        if (DayNumber == 1) {
            setWhiteColorsToDaysButtons()
            MondayButton.backgroundColor = UIColor.lightGray
        }
        if (DayNumber == 2) {
            setWhiteColorsToDaysButtons()
            TuesdayButton.backgroundColor = UIColor.lightGray
        }
        if (DayNumber == 3) {
            setWhiteColorsToDaysButtons()
            WednesdayButton.backgroundColor = UIColor.lightGray
        }
        if (DayNumber == 4) {
            setWhiteColorsToDaysButtons()
            ThursdayButton.backgroundColor = UIColor.lightGray
        }
        if (DayNumber == 5) {
            setWhiteColorsToDaysButtons()
            FridayButton.backgroundColor = UIColor.lightGray
        }
        if (DayNumber == 6) {
            setWhiteColorsToDaysButtons()
            SaturdayButton.backgroundColor = UIColor.lightGray
        }
        if (DayNumber != 0) {
            ChoosenDay = DayNumber
            PeriodicStartDateValue = DateOfBeginOfSemester
            PeriodicEndDateValue = DateOfEndOfSemester
            PeriodicStartDate.text = DateOfBeginOfSemester.stringFromDate()
            PeriodicEndDate.text = DateOfEndOfSemester.stringFromDate()
            ArrayOfCustomDates = Array()
            TableForDates.reloadData()
        }
    }
    
    func setWhiteColorsToDaysButtons(){
        MondayButton.backgroundColor = UIColor.white
        TuesdayButton.backgroundColor = UIColor.white
        WednesdayButton.backgroundColor = UIColor.white
        ThursdayButton.backgroundColor = UIColor.white
        FridayButton.backgroundColor = UIColor.white
        SaturdayButton.backgroundColor = UIColor.white
    }
    
    func SetClassType (CurrentClassType: String?) {
        if (CurrentClassType == nil) {
            SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
            SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
        }
        else {
            if (CurrentClassType == "Лекция") {
                SegmentClassType1.selectedSegmentIndex = 0
                SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
            }
            if (CurrentClassType == "Семинар") {
                SegmentClassType1.selectedSegmentIndex = 1
                SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
            }
            if (CurrentClassType == "Лабораторная") {
                SegmentClassType2.selectedSegmentIndex = 0
                SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
            }
            if (CurrentClassType == "Консультация") {
                SegmentClassType2.selectedSegmentIndex = 1
                SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
            }
            if !((CurrentClassType == "Лекция")||(CurrentClassType == "Семинар")||(CurrentClassType == "Лабораторная")||(CurrentClassType == "Консультация")) {
                SegmentClassType2.selectedSegmentIndex = UISegmentedControlNoSegment
                SegmentClassType1.selectedSegmentIndex = UISegmentedControlNoSegment
                CustomClassTypeButton.backgroundColor = UIColor.blue
                CustomClassTypeButton.setTitleColor(UIColor.white, for: .normal)
                CustomClassTypeButton.setTitleColor(UIColor.lightGray, for: .highlighted)
                CustomClassTypeButtonMode = true
                CustomClassTypeButton.titleLabel?.text = CurrentClassType
            }
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
    
    func  SetParity (CurrentParity: Bool?) {
        if (CurrentParity == nil) {
            ParitySegment.selectedSegmentIndex = 0
        }
        else {
            if (!CurrentParity!) {
                ParitySegment.selectedSegmentIndex = 1
            }
            if (CurrentParity)! {
                ParitySegment.selectedSegmentIndex = 2
            }
        }
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
        ArrayOfCustomDates = Array()
        TableForDates.reloadData()
    }
    
    func SetRegularity (CustomDate: CustomDateClass?) {
        if (CustomDate == nil) {
            RegularitySegment.selectedSegmentIndex = 0
            RegularityView.isHidden = false
            RegularityCustomView.isHidden = true
            CustomDateMode = false
        }
        else {
            RegularitySegment.selectedSegmentIndex = 1
            RegularityView.isHidden = true
            RegularityCustomView.isHidden = false
            CustomDateMode = true
            ArrayOfCustomDates.append(CustomDate!)
            TableForDates.reloadData()
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
        ComplectDatePickerView()
        datePickerInSubview.datePickerMode = UIDatePickerMode.date
        datePickerInSubview.addTarget(self, action: #selector(EditClassController.ChooseCustomDateInTable), for: UIControlEvents.valueChanged)
        self.view.addSubview(customViewForDatePicker)
        if (!AnimationDo) {
            self.AnimationDo = true
            ScrollView.setContentOffset(CGPoint(x: 0, y: RegularityCustomView.frame.origin.y), animated: true)
        }
        CreateNewDateForTableButton.isEnabled = false
    }
    
    // MARK: - ДАТА ПИКЕРЫ
    @IBAction func ChoosePeriodicStartDate(_ sender: Any) {
        ComplectDatePickerView()
        datePickerInSubview.datePickerMode = UIDatePickerMode.date
        PeriodicStartDate.inputView = customViewForDatePicker
        PeriodicStartDate.tintColor = UIColor.clear
        datePickerInSubview.minimumDate = DateOfBeginOfSemester.currentDate
        if (PeriodicStartDate.text != "") {
            datePickerInSubview.setDate(PeriodicStartDateValue.currentDate!, animated: false)
        }
        if (PeriodicEndDate.text != "") {
            datePickerInSubview.maximumDate = PeriodicEndDateValue.currentDate?.addingTimeInterval(-WeekInterval)
        }
        
        datePickerInSubview.addTarget(self, action: #selector(EditClassController.ChangePeriodicStartDateField), for: UIControlEvents.valueChanged)
        if (!AnimationDo) {
            self.AnimationDo = true
            ScrollView.setContentOffset(CGPoint(x: 0, y: RegularityView.frame.origin.y), animated: true)
        }
        ArrayOfCustomDates = Array()
        TableForDates.reloadData()
    }
    
    @IBAction func ChoosePeriodicEndDate(_ sender: Any) {
        ComplectDatePickerView()
        datePickerInSubview.datePickerMode = UIDatePickerMode.date
        PeriodicEndDate.inputView = customViewForDatePicker
        PeriodicEndDate.tintColor = UIColor.clear
        datePickerInSubview.maximumDate = DateOfEndOfSemester.currentDate
        if (PeriodicEndDate.text != "") {
            datePickerInSubview.setDate(PeriodicEndDateValue.currentDate!, animated: false)
        }
        if (PeriodicStartDate.text != "") {
            datePickerInSubview.minimumDate = PeriodicStartDateValue.currentDate?.addingTimeInterval(WeekInterval)
        }
        datePickerInSubview.addTarget(self, action: #selector(EditClassController.ChangePeriodicEndDateField), for: UIControlEvents.valueChanged)
        if (!AnimationDo) {
            self.AnimationDo = true
            ScrollView.setContentOffset(CGPoint(x: 0, y: RegularityView.frame.origin.y), animated: true)
        }
        ArrayOfCustomDates = Array()
        TableForDates.reloadData()
    }
    
    @IBAction func ChooseEndTime(_ sender: Any) {
        ComplectDatePickerView()
        datePickerInSubview.datePickerMode = UIDatePickerMode.time
        datePickerInSubview.minuteInterval = 5
        EndTime.inputView = customViewForDatePicker
        EndTime.tintColor = UIColor.clear
        if (BeginTime.text != "") {
            datePickerInSubview.minimumDate = BeginTimeInDate.currentDate?.addingTimeInterval(FiveMinutesInterval)
            if (EndTime.text == "") {
                EndTimeInDate.currentDate = BeginTimeInDate.currentDate?.addingTimeInterval(5*60)
                EndTime.text = dateFormatterForTime.string(from: EndTimeInDate.currentDate!)
            }
        }
        if (EndTime.text != "") {
            datePickerInSubview.setDate(EndTimeInDate.currentDate!, animated: false)
        }
        else {
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: EndTimeInDate.currentDate!)
            EndTimeInDate.currentDate = EndTimeInDate.currentDate?.addingTimeInterval(TimeInterval(-(min%5 * 60)))
            EndTime.text = dateFormatterForTime.string(from: (EndTimeInDate.currentDate)!)
        }
        datePickerInSubview.addTarget(self, action: #selector(EditClassController.ChangeEndField), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func ChooseBeginTime(_ sender: UITextField) {
        ComplectDatePickerView()
        datePickerInSubview.datePickerMode = UIDatePickerMode.time
        datePickerInSubview.minuteInterval = 5
        BeginTime.inputView = customViewForDatePicker
        BeginTime.tintColor = UIColor.clear
        if (EndTime.text != "") {
            datePickerInSubview.maximumDate = EndTimeInDate.currentDate?.addingTimeInterval(-FiveMinutesInterval)
            if (BeginTime.text == "") {
                BeginTimeInDate.currentDate = EndTimeInDate.currentDate?.addingTimeInterval(-5*60)
                BeginTime.text = dateFormatterForTime.string(from: BeginTimeInDate.currentDate!)
            }
        }
        if (BeginTime.text != "") {
            datePickerInSubview.setDate(BeginTimeInDate.currentDate!, animated: false)
        }
        else {
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: BeginTimeInDate.currentDate!)
            BeginTimeInDate.currentDate = BeginTimeInDate.currentDate?.addingTimeInterval(TimeInterval(-(min%5 * 60)))
            BeginTime.text = dateFormatterForTime.string(from: (BeginTimeInDate.currentDate)!)
        }
        datePickerInSubview.addTarget(self, action: #selector(EditClassController.ChangeBeginField), for: UIControlEvents.valueChanged)
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
        if (CustomDateMode) {
            customViewForDatePicker.removeFromSuperview()
            if (CheckDateInTable(DateForCheck: CustomDateInTable)) {
                ArrayOfCustomDates.append(CustomDateInTable)
            }
            TableForDates.reloadData()
            CreateNewDateForTableButton.isEnabled = true
            setWhiteColorsToDaysButtons()
            PeriodicStartDate.text = ""
            PeriodicEndDate.text = ""
            ParitySegment.selectedSegmentIndex = 0
            CheckSaveButton()
        }
        view.endEditing(true)
        if (AnimationDo) {
            ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            self.AnimationDo = false
        }
    }
    
    @objc func ChooseCustomDateInTable (sender:UIDatePicker) {
        CustomDateInTable = CustomDateClass(withDate: sender.date)
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
    
    // MARK: - ОБРАБОТКА КАСАНИЙ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        if (CustomDateMode) {
            customViewForDatePicker.removeFromSuperview()
            if (CheckDateInTable(DateForCheck: CustomDateInTable)) {
                ArrayOfCustomDates.append(CustomDateInTable)
            }
            TableForDates.reloadData()
            CreateNewDateForTableButton.isEnabled = true
        }
        super.touchesBegan(touches, with: event)
        if (AnimationDo) {
            ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            self.AnimationDo = false
        }
    }
    
    // MARK: - КНОПКА СОХРАНИТЬ
    @IBAction func SaveButtonPressed (_ sender: Any) {
        if ((!(CustomDateMode))||(ArrayOfCustomDates.count == 1)) {
            ComplectInformation()
            if (ArrayOfCustomDates.count == 1) {
                ClassTempModel.classDate = ArrayOfCustomDates[0]
            }
            ClassTempModel.save()
        }
        else {
            for CustomDate in ArrayOfCustomDates {
                ClassTempModel = TimetableModel()
                ComplectInformation()
                ClassTempModel.classDate = CustomDate
                ClassTempModel.save()
            }
        }
        //navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DeleteClass(_ sender: Any) {
        ClassTempModel.delete()
        //navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
        navigationController?.popViewController(animated: true)
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
    
    // MARK: - КОМПЛЕКТАЦИЯ ДАННЫХ
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
        
        self.ScrollView.delegate = self
        
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
        
        if(ClassTempModel == nil){
            ClassTempModel = TimetableModel()
            ChoosenClassType = "Лекция"
        }else{
            initViewWith(Class: ClassTempModel)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initViewWith(Class: TimetableModel){
        SetRegularity(CustomDate: ClassTempModel.classDate)
        ClassRoomField.text = ClassTempModel.classPlace
        SubjectField.text = ClassTempModel.classSubject
        TeacherField.text = ClassTempModel.classTeacher?.name
        ChoosenClassType = ClassTempModel.classType
        SetClassType(CurrentClassType: ChoosenClassType)
        EndTime.text = ClassTempModel.classEndTime
        BeginTime.text = ClassTempModel.classStartTime
        ChoosenDay = Int(ClassTempModel.classWeekDay!)
        ChooseDay(DayNumber: ChoosenDay)
        PeriodicEndDate.text = ClassTempModel.classEndDate?.stringFromDate()
        PeriodicStartDate.text = ClassTempModel.classBeginDate?.stringFromDate()
        ChoosenParity = ClassTempModel.parity
        SetParity(CurrentParity: ChoosenParity)
        CheckSaveButton()
        DeleteClassButton.isHidden = false
    }
}


extension EditClassController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayOfCustomDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dd", for: indexPath) 
        cell.textLabel?.text = ArrayOfCustomDates[indexPath.row].stringFromDate()
        return cell
    }
    
    
}

extension EditClassController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            self.ArrayOfCustomDates.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.CheckSaveButton()
        }
        return [deleteAction]
    }
}
