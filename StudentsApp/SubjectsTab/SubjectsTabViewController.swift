//
//  SubjectsTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class SubjectsTabViewController: UIViewController {
    
    @IBOutlet weak var SubjectTabCollectionView: UICollectionView!
    
    //Количество элементов в строке
    let itemsPerRow = 2
    
    var subjectsArray: [SubjectModel]!
    //Отступы от краев для каждой секции (Всего одна в данном проекте)
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    let reuseIdentifier = "subjectCollectionCell" //
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    

    //func colle
    override func viewDidLoad() {
        super.viewDidLoad()

        subjectsArray = SubjectModel.getSubjects()
        
        self.SubjectTabCollectionView.register(UINib(nibName: "SubjectTabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "subjectCollectionCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UICollectionViewDataSource protocol
extension SubjectsTabViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(subjectsArray.count % 2 == 0){
            return subjectsArray.count/2 + 1
        }else{
            return subjectsArray.count/2;
        }
    }
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if((section+1) * 2 > subjectsArray.count){
            return 1
        }
        return 2//self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SubjectTabCollectionViewCell
        //let cell = Bundle.main.loadNibNamed("SubjectTabCollectionViewCell", owner: self, options: nil)?.first as! SubjectTabCollectionViewCell
        
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.myLabel.text = self.items[indexPath.item]
        let index = indexPath.section * 2 + indexPath.item
        
        if(index >= subjectsArray.count){
            cell.nameLabelOutlet.text = "ADD"
            cell.backgroundColor = UIColor.green
        }else{
            cell.nameLabelOutlet.text =  subjectsArray[index].subjectName //self.items[indexPath.item]
            cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        }

        
        return cell
    }
}
// MARK: - UICollectionViewDelegate protocol
extension SubjectsTabViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}

// MARK: - UICollectionViewLayout protocol
extension SubjectsTabViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
 
        
        //print("HELLO \(sectionInsets.left)")
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        //print("HELLO insetForSectionAt \(sectionInsets.left)")
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //print("HELLO minimumLineSpacingForSectionAt\(sectionInsets.left)")
        //UICollectionView.
        return sectionInsets.left
    }
 
}
