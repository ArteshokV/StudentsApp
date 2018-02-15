//
//  TodayTableViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 22.11.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TodayTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

    let EmptyCellIdentifier = "emptyCell"
    
    var tableConstraints: [NSLayoutConstraint]  {
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .left, relatedBy: .equal,
                                              toItem: self.view, attribute: .left, multiplier: 1.0, constant: 10.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .right, relatedBy: .equal,
                                              toItem: self.view, attribute: .right, multiplier: 1.0, constant: 10.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal,
                                              toItem: self.view, attribute: .top, multiplier: 1.0, constant: 1.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal,
                                              toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 1.0))
        return constraints
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: EmptyCellIdentifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(tableConstraints)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCellIdentifier, for: indexPath)
         cell.textLabel?.text = "TEST"//timeTableArray[indexPath.row].classSubject
     return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
