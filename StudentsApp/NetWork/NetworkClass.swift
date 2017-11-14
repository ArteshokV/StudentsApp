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

struct initalDataResponse: Codable {
//    {"teachers":[],"activities":[],"subjects":[],"tasks":[],"timeTableEvents":[]}
    let teachers: [teacher]
    let activities: [activity]
    let subjects: [subject]
    let tasks: [task]
    let timeTableEvents: [timeTableEvent]
}

struct teacher: Codable {
    let id: Int
    let name: String
    let familyName: String
    let fatherName: String?
}

struct activity: Codable {
    let id: Int
    let shortName: String
    let date: String
    let subject: String
}

struct subject: Codable {
    let id: Int
    let name: String
}

struct task: Codable {
    let id: Int
    let shortName: String
    let date: String
    let subject: String
    let description: String
    let priority: String
    let status: String
}

struct timeTableEvent: Codable {
    let id: Int
    let beginDate: String
    let endDate: String
    let date: String
    let dayOfWeek: Int
    let startTime: Int
    let endTime: Int
    let parity: Int
    let place: String
    let type: String
    let subject: String
    let teacher: teacher?
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
    
    func getInitilData(forUniversity: Int, forFaculty: Int, forGroup: Int, withCompletition: @escaping (initalDataResponse?) -> ()) {
        let urlString = "http://\(apiAdress)/api/dataInit?groupId=\(forGroup)"
        network.getJsonWith(URL: urlString, type: initalDataResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct)
            }
        })
        /*
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
 */
    }
}
