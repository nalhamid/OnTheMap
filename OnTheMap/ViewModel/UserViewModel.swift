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
    //link with model and api
    var userLogin : UserLogin!
    var loginResults : LoginResults!
    
    // Mark:login function
    func login(completion: @escaping (Bool)->()){
        udacityApi.sharedInstance().login(self.userLogin){ results, success in
            // check login json
            var getUserJson = success
            //check if the user login success and he is registered
            if(getUserJson){
                self.saveLoginResults(loginResults: results)
                getUserJson =  self.loginResults.account?.registered ?? false
            }
            if(getUserJson){
                //get user data
                udacityApi.sharedInstance().udacitySession = (self.loginResults.session)!
                
                self.getUser(self.loginResults.account!.key!){ getUserSuccess in
                    DispatchQueue.main.async {
                        getUserJson = getUserSuccess
                        completion(getUserSuccess)
                    }
                }
            }else{
                completion(getUserJson)
            }
        }
    }
    // Mark:logout function
    func logout(completion: @escaping (Bool)->())  {
        udacityApi.sharedInstance().logout(){success in
            if(success){
                // earase user loggin info
                self.userIsLoggedIn(false)
                udacityApi.sharedInstance().udacitySession = nil
            }
            completion(success)
        }
    }
    // Mark:get user function
    func getUser(_ userId: String,completion: @escaping (Bool)->()){
        udacityApi.sharedInstance().getUser(userId){ results, success in
            // check user json
            var getUserSuccess = success
            //check if the user data exist and he is registered
            if(getUserSuccess){
                self.saveStudentInformation(studentInformation: results)
                getUserSuccess =  udacityApi.sharedInstance().studentInformation.user!.registered ?? false
            }
            completion(getUserSuccess)
        }
    }
    // Mark:save login results
    func saveLoginResults (loginResults: LoginResults){
        self.loginResults = loginResults
    }
    // Mark:save user data
    func saveStudentInformation (studentInformation: StudentInformation){
        udacityApi.sharedInstance().studentInformation = studentInformation
    }
    // Mark: save login info
    func saveLogin (username: String, password: String) {
        //  create user login object
        self.userLogin = UserLogin(udacity: authentication(username: username,password: password))
    }
    // Mark: userIsLoggedIn
    func userIsLoggedIn (_ isLoggedIn: Bool){
        udacityApi.sharedInstance().isLoggedIn = isLoggedIn
    }
    // Mark: getUserState
    func getUserState() -> Bool {
        return udacityApi.sharedInstance().isLoggedIn
    }
    // Mark: getUserId
    func getUserId() -> String {
        return udacityApi.sharedInstance().studentInformation.user!.key!
    }
    // Mark: getSessionId
    func getSessionId() -> String {
        return udacityApi.sharedInstance().udacitySession!.id!
    }
    // Mark: getStudentInformation
    func getStudentInformation() -> StudentInformation {
        return udacityApi.sharedInstance().studentInformation
    }
}
