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
        loggedUserDatasource.sharedInstance().loggedUser = StudentLocation()
        loggedUserDatasource.sharedInstance().loggedUser.firstName = "flesh"
        loggedUserDatasource.sharedInstance().loggedUser.lastName = "turtle"
        loggedUserDatasource.sharedInstance().loggedUser.uniqueKey = loggedUserDatasource.sharedInstance().studentInformation.user!.key!
    }
    // Mark: getStudentLocationsList
    func getStudentLocationsList(completion: @escaping (Bool, String)->()){
        // get recent 100 student locations
        parseApi.sharedInstance().get("?limit=100&order=-updatedAt"){ results, success, errorMessage in
            // check user json
            if(success){
                self.saveList(studentList: results)
            }
            completion(success, errorMessage)
        }
    }
    // Mark: getLoggedUserLocation
    func getLoggedUserLocation (completion: @escaping (Bool, String)->()){
        // set query
        let query = "?where=%7B%22uniqueKey%22%3A%22" + self.getUserKey() + "%22%7D"
        // call get method
        parseApi.sharedInstance().get(query){ results, success, errorMessage in
            var isExist = success
            if(success){
                if (results.results.count > 0){
                    self.saveLoggedUser(loggedUser: results.results[0])
                }else{
                    isExist = false
                }
            }
            completion(isExist, errorMessage)
        }
    }
    // Mark: addLocation
    func addLocation(completion: @escaping (Bool, String)->()){
        parseApi.sharedInstance().add(loggedUserDatasource.sharedInstance().loggedUser){ results, success, errorMessage in
            completion(success, errorMessage)
        }
    }
    // Mark: updateLocation
    func updateLocation (completion: @escaping (Bool, String)->()){
        parseApi.sharedInstance().update(loggedUserDatasource.sharedInstance().loggedUser){ results, success, errorMessage in
            completion(success, errorMessage)
        }
    }
    // Mark: saveLocation
    func saveLocation(mapString: String, mediaURL: String,latitude: Float, longitude: Float){
        loggedUserDatasource.sharedInstance().loggedUser.mapString = mapString
        loggedUserDatasource.sharedInstance().loggedUser.mediaURL = mediaURL
        loggedUserDatasource.sharedInstance().loggedUser.latitude = latitude
        loggedUserDatasource.sharedInstance().loggedUser.longitude = longitude
    }
    // Mark: saveList
    func saveList (studentList : StudentList){
        studentsDatasource.sharedInstance().studentList = studentList
    }
    // Mark: saveLoggedUser
    func saveLoggedUser (loggedUser : StudentLocation){
        loggedUserDatasource.sharedInstance().loggedUser = loggedUser
    }
    // Mark: getUserKey
    func getUserKey() -> String {
        return loggedUserDatasource.sharedInstance().loggedUser.uniqueKey!
    }
    func getLocationList() -> [StudentLocation] {
        return studentsDatasource.sharedInstance().studentList.results
    }
    // Mark: refreshList
    func refreshList(completion: @escaping (Bool, String)->()) {
        self.getStudentLocationsList(){success, errorMessage in
            completion(success, errorMessage)
        }
    }
    // Mark: isUserLocationExist
    func isUserLocationExist(completion: @escaping (Bool, String)->()){
        //get user json
        self.getLoggedUserLocation{ success, errorMessage in
            loggedUserDatasource.sharedInstance().locationExist = success
            completion(success, errorMessage)
        }
    }
    // Mark: numberOfRowsInSection
    func numberOfRows() -> Int {
        // get number of students
        return studentsDatasource.sharedInstance().studentList.results.count
    }
    // Mark: titleForIndexPath
    func fullNameForIndexPath(_ indexPath: IndexPath) -> String {
        // get Student Name
        let firstName = studentsDatasource.sharedInstance().studentList.results[indexPath.row].firstName ?? ""
        let lastName = studentsDatasource.sharedInstance().studentList.results[indexPath.row].lastName ?? ""
        return firstName + "" + lastName
    }
    // Mark: linkForIndexPath
    func linkForIndexPath(_ indexPath: IndexPath) -> String {
        // get Student URL
        return studentsDatasource.sharedInstance().studentList.results[indexPath.row].mediaURL ?? "https://udacity.com"
    }
    // Mark: getLocationState
    func getLocationState() -> Bool{
        return loggedUserDatasource.sharedInstance().locationExist
    }
}
