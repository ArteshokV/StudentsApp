//
//  NetworkClass.swift
//  StudentsApp
//
//  Created by Владислав Захаров on 25.10.17.
//  Copyright © 2017 Владислав Захаров. All rights reserved.
//

import UIKit
struct studyUnit: Codable {
    let id: Int
    let name: String
    let description: String?
}

struct studyPlaceResponse: Codable {
    let universities: [studyUnit]?
    let faculties: [studyUnit]?
    let groups: [studyUnit]?
}

class NetworkClass: NSObject {
    let apiAdress = "89.179.244.73:8112/stdApp"
    let network = LowNetworkClass()
    
    func getUniversities(withCompletition: @escaping ([studyUnit]?) -> ()) {
        let urlString = "http://\(apiAdress)/api/studyPlace/universities"
        network.getJsonWith(URL: urlString, type: studyPlaceResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct?.universities)
            }
        })
    }
    
    func getFaculties(forUniversity: Int, withCompletition: @escaping ([studyUnit]?) -> ()) {
        let urlString = "http://\(apiAdress)/api/studyPlace/faculties?university=\(forUniversity)"
        network.getJsonWith(URL: urlString, type: studyPlaceResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct?.faculties)
            }
        })
    }

    
    func getGroups(forUniversity: Int, forFaculty: Int, withCompletition: @escaping ([studyUnit]?) -> ()) {
        let urlString = "http://\(apiAdress)/api/studyPlace/groups?university=\(forUniversity)&faculty=\(forFaculty)"
        network.getJsonWith(URL: urlString, type: studyPlaceResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct?.groups)
            }
        })
    }
    
    func getInitilData(forUniversity: Int, forFaculty: Int, forGroup: Int, withCompletition: @escaping (Any?) -> ()) {
        //let urlString = "http://\(apiAdress)/api/groups?university=\(forUniversity)&faculty=\(forFaculty)&group=\(forGroup)"
        let urlString = "http://\(apiAdress)/api/studyPlace/getJSONinitialDataForRemoteApp"
        network.jetRawJson(URL: urlString, andCompletitionBlock: {json in
            
            //if(json != nil){
                DispatchQueue.main.async {
                    withCompletition(json)
                }
            /*
            }else{
                //print("json = nil")
                DispatchQueue.main.async {
                    withCompletition(nil)
                }
            }
            */
        })
    }
}
