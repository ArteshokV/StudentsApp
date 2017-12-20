//
//  SubjectsTabTableViewCell.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 20.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class SubjectsTabTableViewCell: UITableViewCell {
    
    var subjectLeftModel:SubjectModel?
    var subjectRightModel:SubjectModel?
    
    var parentController: UIViewController!
    
    let bookImage = UIImage(named: "CopyBook")

    @IBOutlet weak var LeftCoverImage: UIImageView!
    @IBOutlet weak var LeftNameLabel: UILabel!
    @IBOutlet weak var RightCoverImage: UIImageView!
    @IBOutlet weak var RightNameLabel: UILabel!
    
    @IBOutlet weak var BlurViewLeft: UIView!
    @IBOutlet weak var BlurViewRight: UIView!
    
    @IBAction func ButtonLeftPressed(_ sender: Any) {
        if(subjectLeftModel?.subjectName == nil){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "AdditionalViews", bundle: nil)
            let addViewController = mainStoryboard.instantiateViewController(withIdentifier: "addSubject") as! AddSubjectViewController
            //self.navigationController?.pushViewController(addViewController, animated: true)
            let nav = UINavigationController(rootViewController: addViewController)
            parentController.present(nav, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Позже", message:
                "Переход к экрану предмета \(subjectLeftModel!.subjectName!)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.default,handler: nil))
            parentController.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func ButtonRightPressed(_ sender: Any) {
        if(subjectRightModel?.subjectName == nil){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "AdditionalViews", bundle: nil)
            let addViewController = mainStoryboard.instantiateViewController(withIdentifier: "addSubject") as! AddSubjectViewController
            //self.navigationController?.pushViewController(addViewController, animated: true)
            let nav = UINavigationController(rootViewController: addViewController)
            parentController.present(nav, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Позже", message:
                "Переход к экрану предмета \(subjectRightModel!.subjectName!)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.default,handler: nil))
            parentController.present(alertController, animated: true, completion: nil)        }
    }
    
    let customAppLook = CustomApplicationLook()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = customAppLook.underLayerColor
        customAppLook.managedLayersContext.append(self)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectViewLeft = UIVisualEffectView(effect: blurEffect)
        blurEffectViewLeft.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        blurEffectViewLeft.frame = LeftNameLabel.bounds
        blurEffectViewLeft.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let blurEffectViewRight = UIVisualEffectView(effect: blurEffect)
        blurEffectViewRight.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        blurEffectViewRight.frame = LeftNameLabel.bounds
        blurEffectViewRight.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        BlurViewRight.addSubview(blurEffectViewRight)
        BlurViewLeft.addSubview(blurEffectViewLeft)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initRowWith(leftModel: SubjectModel, rightModel: SubjectModel){
        self.subjectLeftModel = leftModel
        self.subjectRightModel = rightModel
        self.LeftCoverImage.backgroundColor = UIColor.clear
        self.RightCoverImage.backgroundColor = UIColor.clear
        
        self.BlurViewRight.alpha = 1
        self.BlurViewLeft.alpha = 1
        
        self.LeftCoverImage.image = subjectLeftModel?.subjectImage ?? bookImage
        self.LeftNameLabel.text = subjectLeftModel?.subjectName
        self.RightCoverImage.image = subjectRightModel?.subjectImage ?? bookImage
        self.RightNameLabel.text = subjectRightModel?.subjectName
    }
    
    func initRowWith(LeftModel: SubjectModel){
        self.subjectLeftModel = LeftModel
        self.subjectRightModel = nil
        
        self.BlurViewRight.alpha = 1
        self.BlurViewLeft.alpha = 1
        
        self.LeftCoverImage.image = subjectLeftModel?.subjectImage ?? bookImage
        self.LeftNameLabel.text = subjectLeftModel?.subjectName
        
        self.RightCoverImage.image = #imageLiteral(resourceName: "addTaskIcon")
        //self.RightCoverImage.backgroundColor = UIColor.cyan
        self.LeftCoverImage.backgroundColor = UIColor.clear
        self.RightNameLabel.text = ""
        self.BlurViewRight.alpha = 0
    }
    
    func initRowWithAddButton(){
        self.subjectLeftModel = nil
        self.subjectRightModel = nil
        
        self.BlurViewRight.alpha = 0
        
        //self.LeftCoverImage.backgroundColor = UIColor.cyan
        self.LeftCoverImage.image = #imageLiteral(resourceName: "addTaskIcon")
        self.LeftNameLabel.text = ""
        self.BlurViewLeft.alpha = 0
        
        
        self.RightCoverImage.backgroundColor = UIColor.clear
        self.RightCoverImage.image = nil
        self.RightNameLabel.text = ""
    }
    
}
