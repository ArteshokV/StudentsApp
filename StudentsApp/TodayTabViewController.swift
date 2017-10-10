//
//  TodayTabViewController.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 10.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit

class TodayTabViewController: UIViewController {

    @IBOutlet weak var TodayDateLabel: UILabel!
    @IBOutlet weak var ProgressViewOutlet: UIProgressView!
    @IBOutlet weak var TableViewOutlet: UITableView!
    
    let TimetableCellIdentifier = "TimetableCell"
    let TasksCellIdentifier = "TaskCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressViewOutlet.transform = ProgressViewOutlet.transform.scaledBy(x: 1, y: 20)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDelegate protocol
extension TodayTabViewController: UITableViewDelegate{
    
}

// MARK: - UITableViewDataSource protocol
extension TodayTabViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = (indexPath.section == 0) ? TimetableCellIdentifier : TasksCellIdentifier ;
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        //let row = indexPath.row
        //cell.textLabel?.text = swiftBlogs[row]
        
        return cell
    }
}
