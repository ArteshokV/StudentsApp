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
        
        //Регистрируем объект заднего фона (Полки)
        register(SCSBCollectionReusableView.self, forDecorationViewOfKind: "sectionBackground")
    }
    
    // MARK: layoutAttributesForElementsInRect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var allAttributes = [UICollectionViewLayoutAttributes]()
        
        if let attributes = attributes {
            //Для всех аттрибутов
            for attr in attributes {
                //Находим начала каждой строки (секции) = четные ячейки
                if (attr.representedElementCategory == UICollectionElementCategory.cell && attr.indexPath.item % 2 == 0){
                    //Нашли строку
                    //Создаем объект заднего фона (Полки)
                    let decorationAttributes = SCSBCollectionViewLayoutAttributes(forDecorationViewOfKind: "sectionBackground", with: attr.indexPath)
                    
                    //Вычисляем размер заднего фона (Полки)
                    let tmpWidth = self.collectionView!.contentSize.width
                    let tmpHeight = attr.frame.height
                    let yValue: CGFloat = attr.frame.origin.y + attr.frame.height/2
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
    
    var shelfImage: UIImageView?
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if(shelfImage?.image == nil){
            shelfImage = UIImageView(frame: self.bounds)
            shelfImage?.image = UIImage(named: "ShelfForSubjects")
            //Добавляем картинку на View
            self.addSubview(shelfImage!)
        }
        
    }

}
