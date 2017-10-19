//
//  SubjectsTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class SubjectsTabViewController: UIViewController {
    
    var subjectsArray: [SubjectModel]! //Добавляем пустой массив предметов
    
    @IBOutlet weak var SubjectTabCollectionView: UICollectionView! //Ссылка на Collection View
    
    //Настройка параметров CollectionView
    let itemsPerRow = 2 //Количество элементов в строке
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0) //Отступы от краев для каждой секции (Всего одна в данном проекте)
    let reuseIdentifier = "subjectCollectionCell" //Идентификатор ячейки
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SubjectTabCollectionView.isPrefetchingEnabled = false
        //SubjectTabCollectionView.collectionViewLayout.invalidateLayout()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackGroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 1)
        SubjectTabCollectionView.backgroundColor = UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)//UIColor.clear
        //Полуение массива предметов
        subjectsArray = SubjectModel.getSubjects()
        
        //Добавление кастомной ячейки в Collection View
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
        //Если все ячейки влезают в строки - делаем еще одну для размещения кнопки добавления, если нет, то нужна доп строка для предмета. В любом случае плюс 1
        return subjectsArray.count/2 + 1
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Если количество выведенных ячеек сейчас будет больше, чем нам надо вывести(считая кнопку добавить), то тогда одна ячейка в строке
        if((section+1) * 2 > subjectsArray.count+1){
            return 1
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SubjectTabCollectionViewCell

        //Вычисляем индекс элемента в массиве предметов
        let index = indexPath.section * 2 + indexPath.item
        
        //Если индекс входит в массив, то выводим предмет, если нет - то кнопку добавить
        if(index >= subjectsArray.count){
            cell.nameLabelOutlet.text = "ADD"
            cell.backgroundColor = UIColor.green
        }else{
            cell.nameLabelOutlet.text =  subjectsArray[index].subjectName //self.items[indexPath.item]
            cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        }
        
        return cell
    }
    
   /* func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print(indexPath)
        return UICollectionReusableView()
    }*/
}

// MARK: - UICollectionViewDelegate protocol
extension SubjectsTabViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Обработка нажатия
        print("You selected cell #\(indexPath.item)!")
    }
}

// MARK: - UICollectionViewLayout protocol
extension SubjectsTabViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Вычисляем размер ячейки
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
 
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        //Выдаем размер отступов от секции
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //Выдаем минимальное расстояние  во длине
        return sectionInsets.left
    }
 
}
