//
//  EditClass.swift
//  StudentsApp
//
//  Created by AgentSamogon on 30.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class EditClassController: UIViewController {
    
    private var pickerDataSource = ["8:30", "10:15", "12:00", "13:50", "15:40", "17:25", "19:10"]

    @IBOutlet weak var SegmentClassType1: UISegmentedControl!
    @IBOutlet weak var SegmentClassType2: UISegmentedControl!
    
    @IBOutlet weak var SubjectField: UITextView!
    @IBOutlet weak var TeacherField: UITextField!
    @IBOutlet weak var ClassRoomField: UITextField!
    
    @IBOutlet weak var BeginTime: UITextField!
    
    @IBAction func dsd(_ sender: UITextField) {
        let PickerView:UIPickerView = UIPickerView()
        PickerView.delegate = self
        PickerView.dataSource = self
        BeginTime.inputView = PickerView
        BeginTime.text = pickerDataSource[PickerView.selectedRow(inComponent: 0)]
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

extension EditClassController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
}

extension EditClassController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        BeginTime.text = pickerDataSource[pickerView.selectedRow(inComponent: 0)]
    }
}
