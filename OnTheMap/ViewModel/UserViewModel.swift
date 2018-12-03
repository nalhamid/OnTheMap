//
//  userLoginViewModel.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 16/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation
// Mark: user View Model
class UserViewModel :NSObject{
    //link with model
    var userLogin : UserLogin!
    var loginResults : LoginResults!
    
    // Mark:login function
    func login(completion: @escaping (Bool, String)->()){
        udacityApi.sharedInstance().login(self.userLogin){ results, success, errorMessage in
            // check login json
            var getUserJson = success
            //check if the user login success and he is registered
            if(getUserJson){
                self.saveLoginResults(loginResults: results)
                getUserJson =  self.loginResults.account?.registered ?? false
            }
            if(getUserJson){
                //get user data
                loggedUserDatasource.sharedInstance().udacitySession = (self.loginResults.session)!
                
                self.getUser(self.loginResults.account!.key!){ getUserSuccess, errorMessage in
                    DispatchQueue.main.async {
                        getUserJson = getUserSuccess
                        completion(getUserSuccess, errorMessage)
                    }
                }
            }else{
                completion(getUserJson, errorMessage)
            }
        }
    }
    // Mark:logout function
    func logout(completion: @escaping (Bool, String)->())  {
        udacityApi.sharedInstance().logout(){success, errorMessage in
            if(success){
                // earase user loggin info
                self.userIsLoggedIn(false)
                loggedUserDatasource.sharedInstance().udacitySession = nil
            }
            completion(success, errorMessage)
        }
    }
    // Mark:get user function
    func getUser(_ userId: String,completion: @escaping (Bool, String)->()){
        udacityApi.sharedInstance().getUser(userId){ results, success, errorMessage in
            // check user json
            var getUserSuccess = success
            //check if the user data exist and he is registered
            if(getUserSuccess){
                self.saveStudentInformation(studentInformation: results)
                getUserSuccess =  loggedUserDatasource.sharedInstance().studentInformation.user!.registered ?? false
            }
            completion(getUserSuccess, errorMessage)
        }
    }
    // Mark:save login results
    func saveLoginResults (loginResults: LoginResults){
        self.loginResults = loginResults
    }
    // Mark:save user data
    func saveStudentInformation (studentInformation: StudentInformation){
        loggedUserDatasource.sharedInstance().studentInformation = studentInformation
    }
    // Mark: save login info
    func saveLogin (username: String, password: String) {
        //  create user login object
        self.userLogin = UserLogin(udacity: authentication(username: username,password: password))
    }
    // Mark: userIsLoggedIn
    func userIsLoggedIn (_ isLoggedIn: Bool){
        loggedUserDatasource.sharedInstance().isLoggedIn = isLoggedIn
    }
    // Mark: getUserState
    func getUserState() -> Bool {
        return loggedUserDatasource.sharedInstance().isLoggedIn
    }
    // Mark: getUserId
    func getUserId() -> String {
        return loggedUserDatasource.sharedInstance().studentInformation.user!.key!
    }
    // Mark: getSessionId
    func getSessionId() -> String {
        return loggedUserDatasource.sharedInstance().udacitySession!.id!
    }
    // Mark: getStudentInformation
    func getStudentInformation() -> StudentInformation {
        return loggedUserDatasource.sharedInstance().studentInformation
    }
}
