//
//  DataBaseInitiator.swift
//  StudentsApp
//
//  Created by Иван Галкин on 13.10.2017.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import Foundation
import CoreData

class DataBaseInitiator: NSObject {
    
    func insertInitialData() {
        do{
            let url = Bundle.main.url(forResource: "InitialDataForDB", withExtension: "json")
            //print(url)
            let data = try Data(contentsOf: url!)
            
            var json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            //print(json!)
            json = json!["Timetable"] as! [String: Any]
            json = json!["1"] as! [String: Any]
            print(json!["Date"] as! NSNull)
            //NSNull()
            //if let timetableData = json["Timetable"] as! [String:Any] {
                
            //}
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}
