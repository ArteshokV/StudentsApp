//
//  FirstSetupViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 14.11.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class FirstSetupViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet var MainLabels: [UILabel]!
    @IBOutlet weak var underLayer: UIView!
    
    @IBOutlet weak var UniversityTextView: UITextView!
    @IBOutlet weak var FacultyTextView: UITextView!
    @IBOutlet weak var GroupTextView: UITextView!
    
    @IBOutlet weak var StartDateTextView: UITextField!
    @IBOutlet weak var EndDateTextView: UITextField!
    
    @IBOutlet weak var ContinueButton: UIButton!
    
    let appDesign = CustomApplicationLook()
    let pickerView = UIDatePicker()
    var numberOfFilledFields = 0
    
    override func viewWillAppear(_ animated: Bool) {
        ContinueButton.isEnabled = false
        ContinueButton.setTitleColor(appDesign.subTextColor, for: .normal)
        super.viewWillAppear(animated)
        checkIfAbleToSave()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupPickerView()
        appDesign.initBackground(ofView: self.view)
        
        for label in MainLabels{
            label.textColor = appDesign.mainTextColor
        }
        let textViewsArray:[UITextView] = [UniversityTextView,FacultyTextView,GroupTextView]
        for textView in textViewsArray{
            textView.layer.cornerRadius = 5.0
            textView.textContainer.maximumNumberOfLines = 2
            textView.textContainer.lineBreakMode = .byWordWrapping
            textView.textColor = UIColor.black
            textView.delegate = self
        }
        
        underLayer.backgroundColor = appDesign.underLayerColor
        underLayer.layer.cornerRadius = 15.0
        
        ContinueButton.backgroundColor = appDesign.underLayerColor
        ContinueButton.layer.cornerRadius = 15.0
        ContinueButton.setTitleColor(appDesign.subTextColor, for: .normal)
        // Do any additional setup after loading the view.
        
        StartDateTextView.delegate = self
        EndDateTextView.delegate = self
        
        let parrentView = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2] as! StudyPlaceSelectionViewController
        
        set(textView: UniversityTextView, withPlaceholder: "Введите университет", forSelected: parrentView.selectedUniversity)
        set(textView: FacultyTextView, withPlaceholder: "Введите факультет", forSelected: parrentView.selectedFaculty)
        set(textView: GroupTextView, withPlaceholder: "Введите группу", forSelected: parrentView.selectedGroup)
        
        ContinueButton.isEnabled = false
    }
    
    func set(textView: UITextView, withPlaceholder: String, forSelected: studyUnit?){
        if(forSelected != nil){
            textView.text = forSelected!.name
            textView.isEditable = false
        }else{
            textView.text = withPlaceholder
            textView.textColor = UIColor.lightGray
            textView.isEditable = true
        }
    }
    
    func setupPickerView(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        StartDateTextView.inputAccessoryView = toolbar
        StartDateTextView.inputView = pickerView
        EndDateTextView.inputAccessoryView = toolbar
        EndDateTextView.inputView = pickerView
        
        pickerView.datePickerMode = .date
        
        pickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc func donePressed(){
        view.endEditing(true)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if(textView == UniversityTextView){
                textView.text = "Введите университет"
            }else if(textView == FacultyTextView){
                textView.text = "Введите факультет"
            }else{
                textView.text = "Введите группу"
            }
            textView.textColor = UIColor.lightGray
        }
        checkIfAbleToSave()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let parentPointY = textField.convert(textField.frame.origin, to: ScrollView).y - (textField.inputAccessoryView?.frame.height)!
        let scrollToPoint = CGPoint(x: 0,y: parentPointY - 20)
        ScrollView.setContentOffset(scrollToPoint, animated: true)
        
        //SetTextToPicker
        var dateObject: CustomDateClass
        if((textField.text == nil)||(textField.text == "")){
            dateObject = CustomDateClass()
            if(textField == StartDateTextView){
                textField.text = "01.09.\(dateObject.yearInt!)"
                EndDateTextView.text = "24.12.\(dateObject.yearInt!)"
            }else{
                textField.text = "24.12.\(dateObject.yearInt!)"
                StartDateTextView.text = "01.09.\(dateObject.yearInt!)"
            }
        }
        
        if(textField == StartDateTextView){
            let maxdate = CustomDateClass(withString: EndDateTextView.text!)
            pickerView.maximumDate = maxdate.currentDate
            pickerView.minimumDate = nil
        }else{
            let mindate = CustomDateClass(withString: StartDateTextView.text!)
            pickerView.minimumDate = mindate.currentDate
            pickerView.maximumDate = nil
        }
        dateObject = CustomDateClass(withString: textField.text!)
        pickerView.setDate(dateObject.currentDate!, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint.zero, animated: true)
        checkIfAbleToSave()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            if(StartDateTextView.isEditing){
                StartDateTextView.text = "\(day).\(month).\(year)"
            }else{
                EndDateTextView.text = "\(day).\(month).\(year)"
            }
        }
    }

    func checkIfAbleToSave(){
        if(UniversityTextView.textColor != UIColor.lightGray){
            
        }
        let textViewsArray:[UITextView] = [UniversityTextView,FacultyTextView,GroupTextView]
        for textView in textViewsArray{
            if(textView.textColor == UIColor.lightGray){return}
        }
        if((StartDateTextView.text == "")||(EndDateTextView.text == "")){return}
        ContinueButton.isEnabled = true
        ContinueButton.setTitleColor(appDesign.mainTextColor, for: .normal)
    }
    
    
    @IBAction func ContinueButtonPressed(_ sender: Any) {
        //Сохраняем выбранные значения
        var StudyPlace = [studyUnit(id: -1, name: UniversityTextView.text, description: nil), studyUnit(id: -2, name: FacultyTextView.text, description: nil), studyUnit(id: -3, name: GroupTextView.text, description: nil)]
        do{
            let university = try JSONEncoder().encode(StudyPlace[0])
            let faculty = try JSONEncoder().encode(StudyPlace[1])
            let group = try JSONEncoder().encode(StudyPlace[2])
            UserDefaults.standard.set(university, forKey: "selectedUniversity")
            UserDefaults.standard.set(faculty, forKey: "selectedFaculty")
            UserDefaults.standard.set(group, forKey: "selectedGroup")
        }catch{
            print("Unable to encode selectedJson")
        }
        self.hidesBottomBarWhenPushed = true
        self.performSegue(withIdentifier: "fromFirstToSecondSetup", sender: self)
    }
}
