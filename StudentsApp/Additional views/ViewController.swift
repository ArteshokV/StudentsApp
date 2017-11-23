//
//  ViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 05.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var someLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        //let taskObject: TimetableModel = TimetableModel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//Расширяем UIColor чтобы иметь возможность сохранять его в базу данных
extension UIColor {
    class func color(withData data:Data) -> UIColor {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

//Класс для того, чтобы в Storiboard Выбрать initial Tab у Tab controller
class BaseTabBarController: UITabBarController {
    @IBInspectable var defaultIndex: Int = 3
    let appLook = CustomApplicationLook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBar.tintColor = UIColor.green //Цвет выделения
        self.tabBar.barTintColor = appLook.tabBarColor
        appLook.managedTabBar = self.tabBar
        
        self.tabBar.barStyle = .blackOpaque
        //self.tabBar.alpha = 0.9
        //Добавление Blur effect в Tab bar
        self.tabBar.layer.borderWidth = 0.3
        self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: appLook.blurEffectStyle))
        frost.frame = self.tabBar.bounds
        self.tabBar.insertSubview(frost, at: 0)
        appLook.backgroundBlurView = frost
        
        self.selectedIndex = defaultIndex
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
