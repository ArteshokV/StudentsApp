//
//  AddSubjectViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 23.11.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class AddSubjectViewController: UIViewController {
    @IBOutlet weak var enterSubjectLabel: UILabel!
    
    @IBOutlet weak var enterSubjectTextField: UITextField!
    
    let appDesign = CustomApplicationLook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDesign.initBackground(ofView: self.view)
        enterSubjectLabel.textColor = appDesign.mainTextColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        //self.resignFirstResponder()
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if(enterSubjectTextField.text == nil)||(enterSubjectTextField.text == ""){
            let alertController = UIAlertController(title: "Ошибка", message:
                "Вы ввели пустой предмет!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        /*
        let subject = SubjectModel()
        subject.subjectName = enterSubjectTextField.text
        subject.subjectImage = nil
        // FIXME: Save methods
         */
        SubjectModel.getOrCreateSubjectWith(Name: enterSubjectTextField.text!)
        
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }

}
