//
//  SubjectsTabBackgroundImageLayout.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 09.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class SubjectsTabBackgroundImageLayout: UICollectionViewFlowLayout {
    
    // MARK: prepareLayout
    
    override func prepare() {
        super.prepare()
        
        //minimumLineSpacing = 8.0
        //minimumInteritemSpacing = 20.0
        //minimumLineSpacing = 20
        //sectionInset = UIEdgeInsetsMake(40, 40, 40, 40)
        
        //let width = (UIScreen.main.bounds.width / 3) - 2 * 8.0
        //itemSize = CGSize(width, 100)
        
        
        
        register(SCSBCollectionReusableView.self, forDecorationViewOfKind: "sectionBackground")
    }
    
    // MARK: layoutAttributesForElementsInRect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var allAttributes = [UICollectionViewLayoutAttributes]()
        
        if let attributes = attributes {
            
            for attr in attributes {
                // Look for the first item in a row
                // You can also calculate it by item (remove the second check in the if below and change the tmpWidth and frame origin
                if (attr.representedElementCategory == UICollectionElementCategory.cell && attr.indexPath.item % 2 == 0){ //&& attr.frame.origin.x == self.sectionInset.left) {
                    //print("LayoutAttribute")
                    // Create decoration attributes
                    let decorationAttributes = SCSBCollectionViewLayoutAttributes(forDecorationViewOfKind: "sectionBackground", with: attr.indexPath)
                    
                    // Set the color(s)
                    /*
                    if (attr.indexPath.section % 2 == 0) {
                        decorationAttributes.color = UIColor.green.withAlphaComponent(0.5)
                    } else {
                        decorationAttributes.color = UIColor.blue.withAlphaComponent(0.5)
                    }
                     */
                    
                    //decorationAttributes.color = UIColor.init(patternImage: UIImage(named: "ShelfForSubjects")!)
                    
                    // Make the decoration view span the entire row
                    
                    let tmpWidth = self.collectionView!.contentSize.width
                    let tmpHeight = attr.frame.height//self.itemSize.height //+ self.minimumLineSpacing + self.sectionInset.top / 2 + self.sectionInset.bottom / 2  // or attributes.frame.size.height instead of itemSize.height if dynamic or recalculated
                    let yValue: CGFloat = attr.frame.origin.y + attr.frame.height/2 //- self.sectionInset.top
                    decorationAttributes.frame = CGRect(x: 0, y: yValue, width: tmpWidth, height: tmpHeight)
                    
                    // Set the zIndex to be behind the item
                    decorationAttributes.zIndex = attr.zIndex - 1
                    
                    // Add the attribute to the list
                    allAttributes.append(decorationAttributes)
                }
            }
            // Combine the items and decorations arrays
            allAttributes.append(contentsOf: attributes)
        }
        
        return allAttributes
    }
}



class SCSBCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes {
    var color: UIColor = UIColor.white
    /*
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let newAttributes: SCSBCollectionViewLayoutAttributes = super.copyWithZone(zone) as! SCSBCollectionViewLayoutAttributes
        newAttributes.color = self.color.copyWithZone(zone) as! UIColor
        return newAttributes
    }
 */
}
 

class SCSBCollectionReusableView : UICollectionReusableView {
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        for view in (self.subviews){
            view.removeFromSuperview()
        }
        //let scLayoutAttributes = layoutAttributes as! SCSBCollectionViewLayoutAttributes
        let backgroundImage = UIImageView(frame: self.bounds)
        backgroundImage.image = UIImage(named: "ShelfForSubjects")
        //self.view.insertSubview(backgroundImage, atIndex: 0)
        self.addSubview(backgroundImage) //= scLayoutAttributes.color
        
    }

}
