//
//  parseApi.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 16/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

// Mark: Udacity API
class parseApi {
    //set base URL for API
    let baseURL = "https://parse.udacity.com/parse/classes/StudentLocation"
    //set Parse API keys
    let applicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    // current user info
    var loggedUser = StudentLocation()
    // list of student location 
    var studentList = StudentList()
    // set default value to location exist
    var locationExist = false
    //set all method types
    enum methodType : String {
        case get = "GET"
        case add = "POST"
        case update = "PUT"
    }
    
    //shared instance
    class func sharedInstance() -> parseApi{
        struct Singleton {
            static var sharedInstance = parseApi()
        }
        return Singleton.sharedInstance
    }
}

// Mark: UdacityAPI methods
extension parseApi {
    // Mark: add method
    func get(_ query: String,completion: @escaping (StudentList, Bool)->()){
        //set url request
        let url = URL(string: baseURL + query)
        //set Url Request properaties
        var request = URLRequest(url: url!)
        //set authentication
        request.addValue(applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        //validate login by sending data
        let task = URLSession.shared.dataTask(with: request ) { ( data, _, err)  in
            DispatchQueue.main.async {
                var results = StudentList()
                var success = false
                //check if the request success
                if let err = err {
                    print("Failed to get data from url:", err)
                    success = false
                    return
                }
                guard let data = data else { return }
                
                do {
                    // parse resulting data
                    results  = try JSONDecoder().decode(StudentList.self, from: data)
                    success = true
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    success = false
                }
                // return results
                completion(results,success)
            }
        }
        task.resume()
    }
    
    // Mark: add method
    func add(_ student: StudentLocation, completion: @escaping (StudentLocation, Bool)->()){
        //set url request
        let url = URL(string: baseURL)
        //set Url Request properaties
        var request = URLRequest(url: url!)
        request.httpMethod = methodType.add.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //set authentication
        request.addValue(applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        // parse login Authentication
        request.httpBody = try! JSONEncoder().encode(student)
        //validate login by sending data
        let task = URLSession.shared.dataTask(with: request ) { ( data, _, err)  in
            DispatchQueue.main.async {
                var results : StudentLocation?
                var success = false
                //check if the request success
                if let err = err {
                    print("Failed to get data from url:", err)
                    success = false
                    return
                }
                guard let data = data else { return }
                
                do {
                    // parse resulting data
                    results  = try JSONDecoder().decode(StudentLocation.self, from: data)
                    success = true
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    success = false
                }
                // return results
                completion(results ?? StudentLocation(),success)
            }
        }
        task.resume()
    }
    
    // Mark: update method
    func update(_ student: StudentLocation, completion: @escaping (StudentLocation, Bool)->()){
        print(student.objectId!)
        //set url request
        let url = URL(string: baseURL + "/" + student.objectId!)
        print(baseURL + "/" + student.objectId!)
        //set Url Request properaties
        var request = URLRequest(url: url!)
        request.httpMethod = methodType.update.rawValue
        //set authentication
        request.addValue(applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let updatedLocation = StudentLocation(objectId: nil, uniqueKey: student.uniqueKey!, firstName: student.firstName!, lastName: student.lastName!, mapString: student.mapString!, mediaURL: student.mediaURL!, latitude: student.latitude!, longitude: student.longitude!, createdAt: nil, updatedAt: nil, ACL: nil)
        // parse login Authentication
        request.httpBody = try! JSONEncoder().encode(updatedLocation)
        //validate login by sending data
        let task = URLSession.shared.dataTask(with: request ) { ( data, _, err)  in
            DispatchQueue.main.async {
                var results : StudentLocation?
                var success = false
                //check if the request success
                if let err = err {
                    print("Failed to get data from url:", err)
                    success = false
                    return
                }
                guard let data = data else { return }
                
                do {
                    // parse resulting data and
                    results  = try JSONDecoder().decode(StudentLocation.self, from: data)
                    success = true
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    success = false
                }
                print(results!)
                // return results
                completion(results ?? StudentLocation(),success)
            }
        }
        task.resume()
    }
}
