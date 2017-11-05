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
        self.tabBar.barTintColor = UIColor.white//UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        self.tabBar.barStyle = .blackOpaque
        //self.tabBar.alpha = 0.9
        //Добавление Blur effect в Tab bar
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        frost.frame = self.tabBar.bounds
        //self.tabBar.insertSubview(frost, at: 0)
        
        
        self.selectedIndex = defaultIndex
    }
}

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.white
    @IBInspectable var secondColor: UIColor = UIColor.black
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [firstColor.cgColor, secondColor.cgColor]
    }
}

class CustomApplicationLook: NSObject{
    var backgroundImage: UIImageView!
    var backgroundBlurView: UIVisualEffectView!
    var underLayerColor: UIColor!
    var mainTextColor: UIColor!
    var subTextColor: UIColor!
    var gradientView: GradientView!
    
    override init(){
        super.init()
        
        mainTextColor = UIColor.white
        subTextColor = UIColor.lightGray

        backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackGroundImage")
        
        gradientView = GradientView()
        gradientView.frame = UIScreen.main.bounds
        
        let R = CGFloat(39) //CGFloat(arc4random_uniform(255))
        let G = CGFloat(43) //CGFloat(arc4random_uniform(255))
        let B = CGFloat(52) //CGFloat(arc4random_uniform(255))
        
        gradientView.firstColor = UIColor.red//UIColor(red: R/255, green: G/255, blue: B/255, alpha: 0.6)
        gradientView.secondColor = UIColor.white//UIColor(red: R/255, green: G/255, blue: B/255, alpha: 0.6)
        //backgroundImage.image = nil
        
        backgroundImage.backgroundColor = UIColor.red
        //UIColor(red: R/255, green: G/255, blue: B/255, alpha: 1)
        
        
        let blurEffectBackground = UIBlurEffect(style: .dark)
        backgroundBlurView = UIVisualEffectView(effect: blurEffectBackground)
        backgroundBlurView.frame = UIScreen.main.bounds
        backgroundBlurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundBlurView.alpha = 1
        
        underLayerColor = UIColor(red: 49/255, green: 51/255, blue: 89/255, alpha: 0.25)
        //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
    }
    static func getUnderLayerColor() -> UIColor{
        let R = CGFloat(255)//39) //CGFloat(arc4random_uniform(255))
        let G = CGFloat(255)//43) //CGFloat(arc4random_uniform(255))
        let B = CGFloat(255)//52) //CGFloat(arc4random_uniform(255))
        return //UIColor(red: 49/255, green: 51/255, blue: 89/255, alpha: 0.7)
        //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.6)
        //UIColor(red: R/255, green: G/255, blue: B/255, alpha: 0.5)
        //UIColor(white: 0.6, alpha: 0.7)
        UIColor.black.withAlphaComponent(0.3)
    }
    
    func initBackground(ofView: UIView) {
        ofView.insertSubview(backgroundImage, at: 0)
        //ofView.insertSubview(gradientView, at: 0)
        ofView.insertSubview(backgroundBlurView, at: 1)
    }
}
