//
//  HeaderFooterViewClass.swift
//  StudentsApp
//
//  Created by Admin on 19.10.17.
//  Copyright © 2017 Владислав Саверский. All rights reserved.
//

import UIKit

class HeaderFooterViewClass: UIView {
    
    var mainHeaderLabel: UILabel?
    var attributeHeaderLabel: UILabel?
    
    var footerLabel: UILabel?
    var leftFooterButton: UIButton?
    var rightFooterButton: UIButton?
    
    let customAppLook = CustomApplicationLook()
    
    static let viewHeight:CGFloat = 50.0
    var viewHeight:CGFloat = 50.0
    var viewCornerRadius:CGFloat = 15.0
    var isHeader: Bool!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(frame: CGRect, forHeader: Bool){
        super.init(frame: frame)
        isHeader = forHeader
        if(forHeader){
            self.backgroundColor = customAppLook.underLayerColor
            customAppLook.managedLayersContext.append(self)
            
            mainHeaderLabel = UILabel()
            mainHeaderLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
            mainHeaderLabel?.numberOfLines = 0
            mainHeaderLabel?.adjustsFontSizeToFitWidth = true
            mainHeaderLabel?.minimumScaleFactor = 0.5
            mainHeaderLabel?.textColor = customAppLook.mainTextColor
            customAppLook.managedMainLablesContext.append(mainHeaderLabel!)
            mainHeaderLabel?.textAlignment = .center
            self.addSubview(mainHeaderLabel!)
            
            attributeHeaderLabel = UILabel()
            attributeHeaderLabel?.numberOfLines = 1
            attributeHeaderLabel?.adjustsFontSizeToFitWidth = true
            attributeHeaderLabel?.minimumScaleFactor = 0.2
            attributeHeaderLabel?.textColor = customAppLook.subTextColor
            customAppLook.managedSubLablesContext.append(attributeHeaderLabel!)
            attributeHeaderLabel?.textAlignment = .right
            self.addSubview(attributeHeaderLabel!)
        }else{
            self.backgroundColor = UIColor.clear
            footerLabel = UILabel()
            footerLabel?.backgroundColor = customAppLook.underLayerColor
            customAppLook.managedLayersContext.append(footerLabel!)
            self.addSubview(footerLabel!)
            
            leftFooterButton = UIButton()
            leftFooterButton?.setTitleColor(customAppLook.subTextColor, for: .normal)
            customAppLook.managedSubButonsContext.append(leftFooterButton!)
            self.addSubview(leftFooterButton!)
            
            rightFooterButton = UIButton()
            rightFooterButton?.setTitleColor(customAppLook.subTextColor, for: .normal)
            customAppLook.managedSubButonsContext.append(rightFooterButton!)
            self.addSubview(rightFooterButton!)
        }
        
        layoutSubviews()
    }
    
    func with(cornerRadius:CGFloat) -> HeaderFooterViewClass{
        viewCornerRadius = cornerRadius
        layoutSubviews()
        return self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainHeaderLabel?.frame = CGRect(x:10,y:0,width:(self.frame.width - 10),height:self.frame.height)
        attributeHeaderLabel?.frame = CGRect(x: 3*self.frame.width/4, y: 0, width: self.frame.width/4 - 10, height: self.frame.height)
        leftFooterButton?.frame = CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height-10)
        rightFooterButton?.frame = CGRect(x: self.frame.width/2, y: 0, width: self.frame.width/2, height: self.frame.height-10)
        footerLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height-10)
        
        if(isHeader){
            self.layer.mask = makeRoundedMask(forTop: true, bounds: self.bounds)
        }
        
        footerLabel?.layer.mask = makeRoundedMask(forTop: false, bounds: footerLabel!.bounds)
        leftFooterButton?.layer.cornerRadius = viewCornerRadius
        rightFooterButton?.layer.cornerRadius = viewCornerRadius
    }
    
    private func makeRoundedMask(forTop: Bool, bounds: CGRect) -> CAShapeLayer {
        let corners:UIRectCorner = (forTop ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii:CGSize(width: viewCornerRadius, height: viewCornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
    static func initHeader(withWidth: CGFloat, andMainText: String) -> HeaderFooterViewClass{
        let headerView = HeaderFooterViewClass(frame: CGRect(x:0,y:0,width:withWidth,height:viewHeight), forHeader: true)
        
        headerView.mainHeaderLabel?.text = andMainText
        headerView.attributeHeaderLabel?.isHidden = true
        
        return headerView
    }
    
    static func initFooter(withWidth: CGFloat) -> HeaderFooterViewClass{
        let footerView = HeaderFooterViewClass(frame: CGRect(x:0,y:0,width:withWidth,height:viewHeight), forHeader: false)
        
        footerView.leftFooterButton?.setTitle("Сегодня", for: .normal)
        footerView.leftFooterButton?.isHidden = true
        footerView.rightFooterButton?.setTitle("Завтра", for: .normal)
        footerView.rightFooterButton?.isHidden = true

        return footerView
    }
    
    
    
    
    
    
    
    // static func initRoundedMaskParametrs (cornerRadiiWidth: CGFloat, cornerRadiiHeight: CGFloat) {
    // cornerRadiusWidth = cornerRadiiWidth
    // cornerRadiusHeight = cornerRadiiHeight
    //}
    
    static func makeRoundedMask(forTop: Bool, bounds: CGRect) -> CAShapeLayer {
        let corners:UIRectCorner = (forTop ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii:CGSize(width: 15.0, height: 15/0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
    static func getViewForHeaderInSectionWithLabel (textFronLabel: String, aligment: NSTextAlignment,  tableView: UITableView) ->UIView {
        let sectionHeaderView = UIView()
        let customAppLook = CustomApplicationLook()
        sectionHeaderView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:50)
        sectionHeaderView.layer.mask = makeRoundedMask(forTop: true, bounds: sectionHeaderView.bounds)
        sectionHeaderView.backgroundColor = CustomApplicationLook.getUnderLayerColor()
            //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:10,y:0,width:(tableView.frame.width - 10),height:50)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)
        sectionHeaderLabel.textColor = customAppLook.mainTextColor
        sectionHeaderLabel.numberOfLines = 0
        sectionHeaderLabel.textAlignment = aligment
        sectionHeaderLabel.text = textFronLabel
        sectionHeaderView.addSubview(sectionHeaderLabel)
        
        return sectionHeaderView
    }
    
    static func getViewForFooterInSectionWithLabel (tableView: UITableView) ->UIView {
        let sectionFooterView = UIView()
        sectionFooterView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:50)
        sectionFooterView.backgroundColor = UIColor.clear
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:40)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        
        
        sectionHeaderLabel.backgroundColor = CustomApplicationLook.getUnderLayerColor()
            //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        sectionHeaderLabel.layer.mask = makeRoundedMask(forTop: false, bounds: sectionHeaderLabel.bounds)
        
        sectionFooterView.addSubview(sectionHeaderLabel)
        
        return sectionFooterView
    }
    
    
    static func makeRoundedMaskWithParametrs(forTop: Bool, bounds: CGRect, cornerRadiiWidth: CGFloat, cornerRadiiHeight: CGFloat) -> CAShapeLayer {
        let corners:UIRectCorner = (forTop ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii:CGSize(width: cornerRadiiWidth, height: cornerRadiiHeight))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
    static func getViewForHeaderInSectionWithLabelAndParametrs (textFronLabel: String, tableView: UITableView, height: CGFloat, cornerRadiusWidth: CGFloat, cornerRadiusHeight: CGFloat) ->UIView {
        let sectionHeaderView = UIView()
        let customAppLook = CustomApplicationLook()
        sectionHeaderView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:height)
        sectionHeaderView.layer.mask = makeRoundedMaskWithParametrs(forTop: true, bounds: sectionHeaderView.bounds, cornerRadiiWidth: cornerRadiusWidth, cornerRadiiHeight: cornerRadiusHeight)
        sectionHeaderView.backgroundColor = CustomApplicationLook.getUnderLayerColor()
            //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:10,y:0,width:(tableView.frame.width - 10),height:height)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)
        sectionHeaderLabel.textColor = customAppLook.mainTextColor
        
        sectionHeaderLabel.text = textFronLabel
        sectionHeaderView.addSubview(sectionHeaderLabel)
        
        return sectionHeaderView
    }
    
    static func getViewForFooterInSectionWithLabelAndParametrs (tableView: UITableView, height: CGFloat, distance: CGFloat, cornerRadiusWidth: CGFloat, cornerRadiusHeight: CGFloat) ->UIView {
        let sectionFooterView = UIView()
        sectionFooterView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height: (height + distance))
       // print("\(String(describing: height + distance))")
        sectionFooterView.backgroundColor = UIColor.clear
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:height)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        
        sectionHeaderLabel.backgroundColor = CustomApplicationLook.getUnderLayerColor()
            //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        sectionHeaderLabel.layer.mask = makeRoundedMaskWithParametrs(forTop: false, bounds: sectionHeaderLabel.bounds, cornerRadiiWidth: cornerRadiusWidth, cornerRadiiHeight: cornerRadiusHeight)
        sectionFooterView.addSubview(sectionHeaderLabel)
        
        return sectionFooterView
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
