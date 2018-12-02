//
//  studentLocationViewModel.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 16/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

class StudentLocationViewModel : NSObject{
    
    //initilize from user info
    func setInitUserData() {
        //dummy data
        parseApi.sharedInstance().loggedUser = StudentLocation()
        parseApi.sharedInstance().loggedUser.firstName = "flesh"
        parseApi.sharedInstance().loggedUser.lastName = "turtle"
        parseApi.sharedInstance().loggedUser.uniqueKey = udacityApi.sharedInstance().studentInformation.user!.key!
    }
    // Mark: getStudentLocationsList
    func getStudentLocationsList(completion: @escaping (Bool)->()){
        // get recent 100 student locations
        parseApi.sharedInstance().get("?limit=100&order=-updatedAt"){ results, success in
            // check user json
            if(success){
                self.saveList(studentList: results)
            }
            completion(success)
        }
    }
    // Mark: getLoggedUserLocation
    func getLoggedUserLocation (completion: @escaping (Bool)->()){
        // set query
        let query = "?where=%7B%22uniqueKey%22%3A%22" + self.getUserKey() + "%22%7D"
        // call get method
        parseApi.sharedInstance().get(query){ results, success in
            var isExist = success
            if(success){
                if (results.results.count > 0){
                    self.saveLoggedUser(loggedUser: results.results[0])
                }else{
                    isExist = false
                }
            }
            completion(isExist)
        }
    }
    // Mark: addLocation
    func addLocation(completion: @escaping (Bool)->()){
        parseApi.sharedInstance().add(parseApi.sharedInstance().loggedUser){ results, success in
            completion(success)
        }
    }
    // Mark: updateLocation
    func updateLocation (completion: @escaping (Bool)->()){
        parseApi.sharedInstance().update(parseApi.sharedInstance().loggedUser){ results, success in
            completion(success)
        }
    }
    // Mark: saveLocation
    func saveLocation(mapString: String, mediaURL: String,latitude: Float, longitude: Float){
        parseApi.sharedInstance().loggedUser.mapString = mapString
        parseApi.sharedInstance().loggedUser.mediaURL = mediaURL
        parseApi.sharedInstance().loggedUser.latitude = latitude
        parseApi.sharedInstance().loggedUser.longitude = longitude
    }
    // Mark: saveList
    func saveList (studentList : StudentList){
        parseApi.sharedInstance().studentList = studentList
    }
    // Mark: saveLoggedUser
    func saveLoggedUser (loggedUser : StudentLocation){
        parseApi.sharedInstance().loggedUser = loggedUser
    }
    // Mark: getUserKey
    func getUserKey() -> String {
        return parseApi.sharedInstance().loggedUser.uniqueKey!
    }
    func getLocationList() -> [StudentLocation] {
        return parseApi.sharedInstance().studentList.results
    }
    // Mark: refreshList
    func refreshList(completion: @escaping (Bool)->()) {
        self.getStudentLocationsList(){success in
            completion(success)
        }
    }
    // Mark: isUserLocationExist
    func isUserLocationExist(completion: @escaping (Bool)->()){
        //get user json
        self.getLoggedUserLocation{ success in
            parseApi.sharedInstance().locationExist = success
            completion(success)
        }
    }
    // Mark: numberOfRowsInSection
    func numberOfRows() -> Int {
        // get number of students
        return parseApi.sharedInstance().studentList.results.count
    }
    // Mark: titleForIndexPath
    func fullNameForIndexPath(_ indexPath: IndexPath) -> String {
        // get Student Name
        let firstName = parseApi.sharedInstance().studentList.results[indexPath.row].firstName ?? ""
        let lastName = parseApi.sharedInstance().studentList.results[indexPath.row].lastName ?? ""
        return firstName + "" + lastName
    }
    // Mark: linkForIndexPath
    func linkForIndexPath(_ indexPath: IndexPath) -> String {
        // get Student URL
        return parseApi.sharedInstance().studentList.results[indexPath.row].mediaURL ?? "https://udacity.com"
    }
    // Mark: getLocationState
    func getLocationState() -> Bool{
        return parseApi.sharedInstance().locationExist
    }
}
