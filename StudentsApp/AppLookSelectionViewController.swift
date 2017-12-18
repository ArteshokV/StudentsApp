//
//  AppLookSelectionViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 06.11.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
import CoreData

class AppLookSelectionViewController: UIViewController {

    @IBOutlet weak var AppLooksTable: UITableView!
    let appLookCellIdentifier = "AppLookCell"
    var appLooksArray: [AppLook]!
    
    let appDesign = CustomApplicationLook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never

        appDesign.initBackground(ofView: self.view)
        
        // Do any additional setup after loading the view.
        AppLooksTable.register(UITableViewCell.self, forCellReuseIdentifier: appLookCellIdentifier)
        
        //Получаем массив тем приложения
        let appLooksFetchRequest: NSFetchRequest<AppLook> = AppLook.fetchRequest()
        appLooksArray = (try! DatabaseController.getContext().fetch(appLooksFetchRequest)) as [AppLook]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
    }
}

// MARK: - UITableViewDelegate protocol
extension AppLookSelectionViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let predicate:NSPredicate = NSPredicate(format: "(isSelected == 1)")
        let appLooksFetchRequest: NSFetchRequest<AppLook> = AppLook.fetchRequest()
        appLooksFetchRequest.predicate = predicate
        let selectedLooks = (try! DatabaseController.getContext().fetch(appLooksFetchRequest)) as [AppLook]
        selectedLooks[0].isSelected = false
        
        appLooksArray[indexPath.row].isSelected = true
        DatabaseController.saveContext()
        
        let barsColor = appDesign.tabBarColor.withAlphaComponent(1)
        self.navigationController?.navigationBar.barTintColor = barsColor
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource protocol
extension AppLookSelectionViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appLooksArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: appLookCellIdentifier, for: indexPath)
        cell.textLabel?.text = appLooksArray[indexPath.row].lookName
        cell.backgroundColor = appDesign.underLayerColor
        cell.textLabel?.textColor = appDesign.mainTextColor
        appDesign.managedLayersContext.append(cell)
        appDesign.managedMainLablesContext.append(cell.textLabel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
}
