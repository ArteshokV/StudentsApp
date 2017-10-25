//
//  HeaderFooterViewClass.swift
//  StudentsApp
//
//  Created by Admin on 19.10.17.
//  Copyright © 2017 Владислав Саверский. All rights reserved.
//

import UIKit

class HeaderFooterViewClass: UIView {
    
    
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
    
    static func getViewForHeaderInSectionWithLabel (textFronLabel: String, tableView: UITableView) ->UIView {
        let sectionHeaderView = UIView()
        sectionHeaderView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:50)
        sectionHeaderView.layer.mask = makeRoundedMask(forTop: true, bounds: sectionHeaderView.bounds)
        sectionHeaderView.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:10,y:0,width:(tableView.frame.width - 10),height:50)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)
        sectionHeaderLabel.textColor = UIColor.white
        
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
        
        sectionHeaderLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
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
        sectionHeaderView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:height)
        sectionHeaderView.layer.mask = makeRoundedMaskWithParametrs(forTop: true, bounds: sectionHeaderView.bounds, cornerRadiiWidth: cornerRadiusWidth, cornerRadiiHeight: cornerRadiusHeight)
        sectionHeaderView.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:10,y:0,width:(tableView.frame.width - 10),height:height)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)
        sectionHeaderLabel.textColor = UIColor.white
        
        sectionHeaderLabel.text = textFronLabel
        sectionHeaderView.addSubview(sectionHeaderLabel)
        
        return sectionHeaderView
    }
    
    static func getViewForFooterInSectionWithLabelAndParametrs (tableView: UITableView, height: CGFloat, distance: CGFloat, cornerRadiusWidth: CGFloat, cornerRadiusHeight: CGFloat) ->UIView {
        let sectionFooterView = UIView()
        sectionFooterView.frame = CGRect(x:0,y:0,width:tableView.frame.width,height: (height + distance))
        sectionFooterView.backgroundColor = UIColor.clear
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.frame = CGRect(x:0,y:0,width:tableView.frame.width,height:height)
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        
        sectionHeaderLabel.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
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
