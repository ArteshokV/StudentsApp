//
//  CustomApplicationLook.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 08.11.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Gradient View

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

// MARK: - App Look Class
class CustomApplicationLook: NSObject, NSFetchedResultsControllerDelegate{
    // MARK: Variables
    var backgroundImageView: UIImageView?
    var backgroundBlurView: UIVisualEffectView?
    var gradientView: GradientView?
    var backgroundImage: UIImage?
    var underLayerColor: UIColor!
    var mainTextColor: UIColor!
    var subTextColor: UIColor!
    var firstGradientColor: UIColor?
    var secondGradientColor: UIColor?
    var tabBarColor: UIColor!
    var blurEffectStyle: UIBlurEffectStyle!
    
    var managedMainLablesContext: [UILabel?]!
    var managedSubLablesContext: [UILabel?]!
    var managedLayersContext: [UIView?]!
    var managedMainButonsContext: [UIButton?]!
    var managedSubButonsContext: [UIButton?]!
    var managedTabBar: UITabBar?
    
    var fetchController: NSFetchedResultsController<AppLook>!
    
    // MARK: - Init functions
    override init(){
        super.init()
        
        managedMainLablesContext = [UILabel?]()
        managedSubLablesContext = [UILabel?]()
        managedLayersContext = [UIView?]()
        managedMainButonsContext = [UIButton?]()
        managedSubButonsContext = [UIButton?]()
        
        let predicate:NSPredicate = NSPredicate(format: "(isSelected == 1)")
        let sortDescriptor = NSSortDescriptor(key: #keyPath(AppLook.lookName), ascending: false)
        let appLooksFetchRequest: NSFetchRequest<AppLook> = AppLook.fetchRequest()
        appLooksFetchRequest.predicate = predicate
        appLooksFetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchController = NSFetchedResultsController(fetchRequest: appLooksFetchRequest, managedObjectContext: DatabaseController.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        fetchController.delegate = self
        
        try! fetchController.performFetch()
        
        
        var selectedLooks = fetchController.fetchedObjects! //(try! DatabaseController.getContext().fetch(appLooksFetchRequest)) as [AppLook]
        
        let selectedLook: AppLook!
        if(selectedLooks.count == 0){
            //При первом старте приложения
            //let initor = DataBaseInitiator()
            //initor.initStandartAppLooks()
            print("NO LOOKS")
            
            selectedLook = nil
            firstGradientColor = UIColor.red
            secondGradientColor = UIColor.blue
            tabBarColor = UIColor.white
            blurEffectStyle = UIBlurEffectStyle.dark
            return
        }else{
            selectedLook =  selectedLooks[0]
        }
        
        initWith(DatabaseObject: selectedLook)
        
    }
    
    func initWith(DatabaseObject: AppLook){
        
        mainTextColor = DatabaseObject.mainTextColor as! UIColor
        subTextColor = DatabaseObject.subTextColor as! UIColor
        
        firstGradientColor = DatabaseObject.gradientUpperColor as? UIColor
        secondGradientColor = DatabaseObject.gradientLowerColor as? UIColor
        
        backgroundImage = DatabaseObject.backGroundImage as? UIImage
        
        tabBarColor = DatabaseObject.tabBarColor as! UIColor
        
        if(DatabaseObject.blurViewStyle == "dark"){
            blurEffectStyle = UIBlurEffectStyle.dark
        }else if(DatabaseObject.blurViewStyle == "light"){
            blurEffectStyle = UIBlurEffectStyle.light
        }
        
        underLayerColor = DatabaseObject.underLayerColor as! UIColor
    }
    
    // MARK: - Updating Context
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        initWith(DatabaseObject: fetchController.fetchedObjects![0])
        
        if(backgroundImageView != nil){updateBackGroundViews()}
        if(managedTabBar != nil){
            managedTabBar!.barTintColor = tabBarColor
            let blurEffectBackground = UIBlurEffect(style: blurEffectStyle)
            backgroundBlurView?.effect = blurEffectBackground
            
            if(blurEffectStyle == UIBlurEffectStyle.light){
                UIApplication.shared.statusBarStyle = .default
            }else{
                UIApplication.shared.statusBarStyle = .lightContent
            }
        }
        
        updateManagedContext()
    }
    
    func updateManagedContext(){
        for mainLabel in managedMainLablesContext{
            mainLabel?.textColor = mainTextColor
        }
        for subLabel in managedSubLablesContext{
            subLabel?.textColor = subTextColor
        }
        for layerIn in managedLayersContext{
            layerIn?.backgroundColor = underLayerColor
        }
        for button in managedMainButonsContext{
            button?.setTitleColor(mainTextColor, for: .normal)
        }
        for button in managedSubButonsContext{
            button?.setTitleColor(subTextColor, for: .normal)
        }
    }
    
    // MARK: - Background Views
    func initBackground(ofView: UIView) {
        makeFramesForViews()
        updateBackGroundViews()
        
        ofView.insertSubview(backgroundImageView!, at: 0)
        ofView.insertSubview(gradientView!, at: 1)
        ofView.insertSubview(backgroundBlurView!, at: 2)
    }
    
    func makeFramesForViews(){
        backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        gradientView = GradientView()
        gradientView?.frame = UIScreen.main.bounds
        let blurEffectBackground = UIBlurEffect(style: .dark)
        backgroundBlurView = UIVisualEffectView(effect: blurEffectBackground)
        backgroundBlurView?.effect = blurEffectBackground
        backgroundBlurView?.frame = UIScreen.main.bounds
        backgroundBlurView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundBlurView?.alpha = 0.98
    }
    
    func updateBackGroundViews(){
        if(backgroundImage != nil){
            backgroundImageView?.image = backgroundImage
            backgroundImageView?.isHidden = false
            gradientView?.isHidden = true
        }else{
            gradientView?.firstColor = firstGradientColor!
            gradientView?.secondColor = secondGradientColor!
            gradientView?.layoutSubviews()
            gradientView?.isHidden = false
            backgroundImageView?.isHidden = true
        }
        
        let blurEffectBackground = UIBlurEffect(style: blurEffectStyle)
        backgroundBlurView?.effect = blurEffectBackground
    }
    
    // MARK: - Unused
    static func getUnderLayerColor() -> UIColor{
        let predicate:NSPredicate = NSPredicate(format: "(isSelected == 1)")
        let appLooksFetchRequest: NSFetchRequest<AppLook> = AppLook.fetchRequest()
        appLooksFetchRequest.predicate = predicate
        
        var selectedLooks = (try! DatabaseController.getContext().fetch(appLooksFetchRequest)) as [AppLook]
        if(selectedLooks.count != 0){
            let selectedLook =  selectedLooks[0]
            return selectedLook.underLayerColor as! UIColor
        }else{
            return UIColor.orange
        }
    }
}

