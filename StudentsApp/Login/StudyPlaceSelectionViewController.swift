//
//  StudyPlaceSelectionViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 24.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class StudyPlaceSelectionViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var UnivercityButton: UIButton!
    @IBOutlet weak var FacultyButton: UIButton!
    @IBOutlet weak var GroupButton: UIButton!
    @IBOutlet weak var connectionSpinner: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var ContainerView: UIView!
    
    var searchBar: UISearchBar!
    var blurEffectView: UIVisualEffectView!
    
    var SearchController: UISearchController!
    var resultsController: UITableViewController!
    var qurrentArray: [studyUnit]!
    var filteredArray: [studyUnit]!
    
    var selectedUniversity: studyUnit!
    var selectedFaculty: studyUnit!
    var selectedGroup: studyUnit!
    
    var workingWithPlaceType = 0

    // MARK: - initialSetupOfView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundAndBlurView()
        setSearchController()
        
        FacultyButton.isHidden = true
        GroupButton.isHidden = true
        StartButton.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        setButtonFrame(forButton: UnivercityButton)
        setButtonFrame(forButton: FacultyButton)
        setButtonFrame(forButton: GroupButton)
        
        setButtonFrame(forButton: StartButton)
        StartButton.backgroundColor = UIColor(red: 10/255, green: 157/255, blue: 15/255, alpha: 0.25)
    }
    
    func setBackGroundAndBlurView(){
        let screenLook = CustomApplicationLook()
        
        self.view.insertSubview(screenLook.backgroundImage, at: 0)
        self.view.insertSubview(screenLook.backgroundBlurView, at: 1)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.safeAreaLayoutGuide.layoutFrame //view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.0;
        self.view.addSubview(blurEffectView)
        
        self.view.bringSubview(toFront: ContainerView)
        connectionSpinner.alpha = 0
        self.view.bringSubview(toFront: connectionSpinner)
    }
    
    func setSearchController(){
        resultsController = UITableViewController()
        resultsController.tableView.delegate = self
        resultsController.tableView.dataSource = self
        resultsController.tableView.rowHeight = UITableViewAutomaticDimension
        resultsController.tableView.backgroundColor = UIColor.clear
        //resultsController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        SearchController = UISearchController(searchResultsController: resultsController)
        //resultsController.tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        resultsController.tableView.sizeToFit()
        resultsController.tableView.clipsToBounds = true
        SearchController.searchResultsUpdater = self
        SearchController.obscuresBackgroundDuringPresentation = false
        SearchController.dimsBackgroundDuringPresentation = true
        
        searchBar = SearchController.searchBar
        SearchController.searchBar.sizeToFit()
        searchBar.clipsToBounds = true
        self.ContainerView.addSubview(searchBar)
        ContainerView.alpha = 0.0
        
        definesPresentationContext = true
    }
    
    func setButtonFrame(forButton: UIButton){
        forButton.layer.cornerRadius = 15.0
        forButton.backgroundColor = UIColor(red: 153/255, green: 189/255, blue: 160/255, alpha: 0.4)
        //UIColor(red: 153/255, green: 157/255, blue: 163/255, alpha: 0.25)
        
        forButton.clipsToBounds = true
        forButton.titleLabel?.numberOfLines = 0
        forButton.titleLabel?.textAlignment = .center
    }
    
    // MARK: - ButtonsPressProcessing
    @IBAction func SetUniversityPressed(_ sender: UIButton) {
        searchBar.placeholder = "Выберите университет"
        networkIndicator(show: true)
        workingWithPlaceType = 0
        
        let query = NetworkClass()
        query.getUniversities(withCompletition: {(response) in
            self.networkIndicator(show: false)
            
            if(response != nil){
                self.qurrentArray = response
                self.filteredArray = response
                self.showSearchBar()
            }else{
                self.displayDownloadError()
            }
        })
    }
    
    @IBAction func SetFacultyPressed(_ sender: UIButton) {
        searchBar.placeholder = "Выберите факультет"
        networkIndicator(show: true)
        workingWithPlaceType = 1
        
        let query = NetworkClass()
        query.getFaculties(forUniversity: selectedUniversity.id, withCompletition: {(response) in
            self.networkIndicator(show: false)
            
            if(response != nil){
                self.qurrentArray = response
                self.filteredArray = response
                self.showSearchBar()
            }else{
                self.displayDownloadError()
            }
        })
    }
    
    @IBAction func SetGroupPressed(_ sender: UIButton) {
        searchBar.placeholder = "Выберите группу"
        networkIndicator(show: true)
        workingWithPlaceType = 2
        
        let query = NetworkClass()
        query.getGroups(forUniversity: selectedUniversity.id, forFaculty: selectedFaculty.id, withCompletition: {(response) in
            self.networkIndicator(show: false)
            
            if(response != nil){
                self.qurrentArray = response
                self.filteredArray = response
                self.showSearchBar()
            }else{
                self.displayDownloadError()
            }
        })
    }
    
    @IBAction func StartUsingPressed(_ sender: UIButton) {
        networkIndicator(show: true)
        let query = NetworkClass()
        query.getInitilData(forUniversity: selectedUniversity.id, forFaculty: selectedFaculty.id, forGroup: selectedGroup.id, withCompletition: {(response) in
            self.networkIndicator(show: false)
            
            if(response != nil){
                let dbInitor = DataBaseInitiator()
                dbInitor.insertInitialData(withJson: response)
            }else{
                self.displayDownloadError()
            }
        })
        self.performSegue(withIdentifier: "StartUsing", sender: self)
    }
    
    func displayDownloadError(){
        let alertController = UIAlertController(title: "Ошибка", message:
            "Произошла ошибка при загрузке списка, попробуйте позже!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

    func networkIndicator(show: Bool){
        var showAlpha: CGFloat = 0
        
        if(show){
            showAlpha = 1.0
        }else{
            showAlpha = 0.0
        }
        spinConnectionSpinner()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.connectionSpinner.alpha = showAlpha
            self.blurEffectView.alpha = showAlpha
            if(show){
                self.blurEffectView.frame = self.stackView.frame
                self.blurEffectView.layer.cornerRadius = 15.0
                self.blurEffectView.clipsToBounds = true
            }else{
                self.blurEffectView.frame = self.view.safeAreaLayoutGuide.layoutFrame //self.view.bounds
                self.blurEffectView.layer.cornerRadius = 0.0
                self.blurEffectView.clipsToBounds = false
            }
        }, completion: nil)
    }
    
    func spinConnectionSpinner(){
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.connectionSpinner.transform = self.connectionSpinner.transform.rotated(by: .pi)
        }) { (finished) -> Void in
            if(self.connectionSpinner.alpha != 0){
                self.spinConnectionSpinner()
            }
        }
    }
    
    func showSearchBar(){
        self.searchBar.showsCancelButton = true
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.ContainerView.alpha = 1.0
            self.blurEffectView.alpha = 1.0;
        }, completion: { _ in self.searchBar.becomeFirstResponder()})
    }
}



// MARK: - UISearchResultsUpdating protocol
extension StudyPlaceSelectionViewController: UISearchResultsUpdating, UISearchControllerDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        if(searchController.isActive == false){
            dismissSearchBar()
        }
        if(searchBar.text! != ""){
            filteredArray = qurrentArray.filter ({ (qurrentArray:studyUnit) -> Bool in
                return qurrentArray.name.lowercased().contains(searchController.searchBar.text!.lowercased())
            })
            filteredArray.sort { (lhs: studyUnit, rhs: studyUnit) -> Bool in
                // you can have additional code here
                return lhs.name < rhs.name
            }
        }else{
            resultsController.tableView.isHidden = false
            filteredArray = qurrentArray
            filteredArray.sort { (lhs: studyUnit, rhs: studyUnit) -> Bool in
                // you can have additional code here
                return lhs.name < rhs.name
            }
        }
        resultsController.tableView.reloadData()
        
    }
    func dismissSearchBar(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.ContainerView.alpha = 0.0
            self.blurEffectView.alpha = 0.0;
        }, completion: nil)
    }
}

// MARK: - UITableViewDataSource protocol
extension StudyPlaceSelectionViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filteredArray != nil){
            let numberOfRows = (filteredArray.count != 0 ? filteredArray!.count : 1)
            tableView.separatorColor = UIColor.white
            return numberOfRows
        }else{
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
            cell!.layer.cornerRadius = 20
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.numberOfLines = 0
            cell!.detailTextLabel?.textColor = UIColor.lightGray
        }
        
        cell!.backgroundColor = CustomApplicationLook.getUnderLayerColor()
        
        if(filteredArray.count == 0){
            cell!.textLabel?.text = "Не нашли? Не беда, можно добавить!"
            cell!.detailTextLabel?.text = "Щелкните для добавления"
            cell!.backgroundColor = UIColor(red: 10/255, green: 157/255, blue: 15/255, alpha: 0.25)
            tableView.separatorColor = UIColor.clear
            return cell!
        }
        
        cell!.textLabel?.text = filteredArray[indexPath.row].name
        cell!.detailTextLabel?.text = filteredArray[indexPath.row].description
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
}

// MARK: - UITableViewDelegate protocol
extension StudyPlaceSelectionViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(filteredArray.count == 0){
            print("ADD SOMETHING")
            SearchController.dismiss(animated: true, completion: nil)
            searchBar.text = ""
            dismissSearchBar()
            return
        }
        
        if(workingWithPlaceType == 0){
            selectedUniversity = filteredArray[indexPath.row]
            selectedFaculty = nil
            selectedGroup = nil
            univrecitySelected(withText: filteredArray[indexPath.row].name)
        }else if(workingWithPlaceType == 1){
            selectedFaculty = filteredArray[indexPath.row]
            selectedGroup = nil
            facultySelected(withText: filteredArray[indexPath.row].name)
        }else if(workingWithPlaceType == 2){
            selectedGroup = filteredArray[indexPath.row]
            groupSelected(withText: filteredArray[indexPath.row].name)
        }
        
        SearchController.dismiss(animated: true, completion: nil)
        searchBar.text = ""
        dismissSearchBar()
    }
    
    func univrecitySelected(withText: String){
        StartButton.isHidden = true
        GroupButton.isHidden = true
        
        FacultyButton.isHidden = false
        FacultyButton.setTitle("Выберите факультет", for: .normal)

        UnivercityButton.setTitle(withText, for: .normal)
    }
    
    func facultySelected(withText: String){
        StartButton.isHidden = true
        
        GroupButton.isHidden = false
        
        GroupButton.setTitle("Выберите группу", for: .normal)
        FacultyButton.setTitle(withText, for: .normal)
    }
    
    func groupSelected(withText: String){
        StartButton.isHidden = false
        
        let attributedString = NSAttributedString(string: withText)
        GroupButton.setAttributedTitle(attributedString, for: .normal)
    }
}
