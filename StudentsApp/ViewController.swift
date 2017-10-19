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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//Класс для того, чтобы в Storiboard Выбрать initial Tab у Tab controller
class BaseTabBarController: UITabBarController {
    @IBInspectable var defaultIndex: Int = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBar.tintColor = UIColor.green //Цвет выделения
        self.tabBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabBar.alpha = 0.9
        //Добавление Blur effect в Tab bar
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        frost.frame = self.tabBar.bounds
        self.tabBar.insertSubview(frost, at: 0)
        
        
        self.selectedIndex = defaultIndex
    }
}
