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
    var subjects: [subject]?
    var timeTableEvents: [timeTableEvent]?
    var teachers: [teacher]?
    var activities: [activity]?
    var tasks: [task]?
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
    var id: Int?
    var shortName: String?
    var date: String?
    var subject: String?
    var description: String?
    var priority: Int16?
    var status: Int16?
}

struct timeTableEvent: Codable {
    let id: Int
    let beginDate: String?
    let endDate: String?
    let date: String?
    let dayOfWeek: Int16?
    let startTime: Int16
    let endTime: Int16
    let parity: Bool?
    let place: String
    let type: String
    let subject: String
    let teacher: teacher?
}

class NetworkClass: NSObject {
    let apiAdress = "46.188.72.4:8112/stdApp" //"172.20.10.11:8080/SSA"
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
        print("Starting init data fetch for group \(forGroup)")
        let urlString = "http://\(apiAdress)/api/dataInit?groupId=\(forGroup)"
        network.getJsonWith(URL: urlString, type: initalDataResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct)
            }
        })
    }
        
    func doSync(withCompletition: @escaping (initalDataResponse?) -> (), dataToSend:String?) {
            print("Starting sync")
            let urlString = "http://\(apiAdress)/api/sync"
            network.sendDataWith(URL: urlString, type: initalDataResponse.self, andCompletitionBlock: {responseStruct in
                DispatchQueue.main.async {
                    withCompletition(responseStruct)
                }
            }, dataToSend: dataToSend)
    }
}
