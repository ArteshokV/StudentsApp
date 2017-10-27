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
    let apiAdress = "89.179.244.73:8112/stdApp/testEnv"
    
    func getUniversities(withCompletition: @escaping ([studyUnit]?) -> ()) {
        let urlString = "http://\(apiAdress)/api/universities"
        let network = LowNetworkClass()
        network.getJsonWith(URL: urlString, type: studyPlaceResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct!.universities)
            }
        })
    }
    
    func getFaculties(forUniversity: Int, withCompletition: @escaping ([studyUnit]?) -> ()) {
        let urlString = "http://\(apiAdress)/api/faculties?university=\(forUniversity)"
        let network = LowNetworkClass()
        network.getJsonWith(URL: urlString, type: studyPlaceResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct!.faculties)
            }
        })
    }

    
    func getGroups(forUniversity: Int, forFaculty: Int, withCompletition: @escaping ([studyUnit]?) -> ()) {
        let urlString = "http://\(apiAdress)/api/groups?university=\(forUniversity)&faculty=\(forFaculty)"
        let network = LowNetworkClass()
        network.getJsonWith(URL: urlString, type: studyPlaceResponse.self, andCompletitionBlock: {responseStruct in
            DispatchQueue.main.async {
                withCompletition(responseStruct!.groups)
            }
        })
    }
    
    func getInitilData(forUniversity: Int, forFaculty: Int, forGroup: Int, withCompletition: @escaping (Any?) -> ()) {
        //let urlString = "http://\(apiAdress)/api/groups?university=\(forUniversity)&faculty=\(forFaculty)&group=\(forGroup)"
        let urlString = "http://89.179.244.73:8112/stdApp/testEnv/api/getJSONinitialDataForRemoteApp"
        setJsonSessionFor(URL: urlString, andCompletitionBlock: {json in
            
            if(json != nil){
                DispatchQueue.main.async {
                    withCompletition(json)
                }
                
            }else{
                //print("json = nil")
                DispatchQueue.main.async {
                    withCompletition(nil)
                }
            }
            
        })
    }
}

func setJsonSessionFor(URL: String, andCompletitionBlock: @escaping (Any?) -> Void){
    
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.timeoutIntervalForRequest = 7.0
    sessionConfiguration.timeoutIntervalForResource = 7.0
    
    let defaultSession = URLSession(configuration: sessionConfiguration)
    var dataTask: URLSessionDataTask?
    dataTask?.cancel()
    
    let encodedString = URL.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

    if var urlComponents = URLComponents(string: encodedString!) {
        guard let url = urlComponents.url else {
            print("BadComponents.url")
            andCompletitionBlock(nil)
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { dataTask = nil }
            //If Error of connection came
            if let error = error {
                let errorMessage = "DataTask error: " + error.localizedDescription + "\n"
                print(errorMessage)
                andCompletitionBlock(nil)
            } else if let data = data,
            //If connection is good and we got something
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do{
                    //let type = studyPlaceResponse.self
                    let json = try JSONSerialization.jsonObject(with: data)
                    //print("Got JSON - \(json)")
                    andCompletitionBlock(json)
                } catch{
                    print("Error with parsing json")
                    andCompletitionBlock(nil)
                }
            }else{
                print("No error, but statusCode != 200")
                andCompletitionBlock(nil)
            }
        }
        dataTask?.resume()
    }else{
        andCompletitionBlock(nil)
        print("BadComponents with string")
    }
}
