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

    @IBOutlet weak var LeftCoverImage: UIImageView!
    @IBOutlet weak var LeftNameLabel: UILabel!
    @IBOutlet weak var RightCoverImage: UIImageView!
    @IBOutlet weak var RightNameLabel: UILabel!
    
    @IBOutlet weak var BlurViewLeft: UIView!
    @IBOutlet weak var BlurViewRight: UIView!
    
    @IBAction func ButtonLeftPressed(_ sender: Any) {
        print(subjectLeftModel?.subjectName as Any)
    }
    @IBAction func ButtonRightPressed(_ sender: Any) {
        print(subjectRightModel?.subjectName as Any)
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
        
        self.BlurViewRight.alpha = 1
        
        self.LeftCoverImage.image = subjectLeftModel?.subjectImage ?? UIImage(named: "BackGroundImage")
        self.LeftNameLabel.text = subjectLeftModel?.subjectName
        self.RightCoverImage.image = subjectRightModel?.subjectImage ?? UIImage(named: "BackGroundImage")
        self.RightNameLabel.text = subjectRightModel?.subjectName
    }
    
    func initRowWith(LeftModel: SubjectModel){
        self.subjectLeftModel = LeftModel
        self.subjectRightModel = nil
        
        self.BlurViewRight.alpha = 1
        
        self.LeftCoverImage.image = subjectLeftModel?.subjectImage ?? UIImage(named: "BackGroundImage")
        self.LeftNameLabel.text = subjectLeftModel?.subjectName
        
        self.RightCoverImage.image = nil
        self.RightCoverImage.backgroundColor = UIColor.cyan
        self.RightNameLabel.text = "Добавить"
    }
    
    func initRowWithAddButton(){
        self.subjectLeftModel = nil
        self.subjectRightModel = nil
        
        self.BlurViewRight.alpha = 0
        
        self.LeftCoverImage.backgroundColor = UIColor.cyan
        self.LeftNameLabel.text = "Добавить"
        
        self.RightCoverImage.backgroundColor = UIColor.clear
        self.RightCoverImage.image = nil
        self.RightNameLabel.text = ""
    }
    
}
