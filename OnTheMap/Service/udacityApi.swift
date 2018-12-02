//
//  udacityAPI.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 12/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

// Mark: Udacity API
class udacityApi {
    // shared session
    var sharedSession = URLSession.shared
    //set base URL for API
    let baseURL = "https://www.udacity.com/api/"
    // seassion ID
    var udacitySession : session? = nil
    // studentInformation
    var studentInformation = StudentInformation ()
    // user state
    var isLoggedIn = false
    //set all methods names
    enum methodName : String {
        case session = "session"
        case users = "users/"
    }
    //set all method types
    enum methodType : String {
        case login = "POST"
        case logout = "DELETE"
        case get = "GET"
    }
    
    //shared instance
    class func sharedInstance() -> udacityApi{
        struct Singleton {
            static var sharedInstance = udacityApi()
        }
        return Singleton.sharedInstance
    }
}

// Mark: UdacityAPI methods
extension udacityApi {
    // Mark: Login method from Udacity API
    func login(_ userLogin: UserLogin,completion: @escaping (LoginResults, Bool)->()){
        //set url request
        let url = URL(string: baseURL + methodName.session.rawValue)
        //set Url Request properaties
        var request = URLRequest(url: url!)
        request.httpMethod = methodType.login.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // parse login Authentication
        let encoder = JSONEncoder()
        request.httpBody = try! encoder.encode(userLogin)
        //validate login by sending data
        let task = sharedSession.dataTask(with: request ) { data, _, err in
            var results : LoginResults?
            var success = false
            //check if the request success
            if let err = err {
                print("Failed to get data from url:", err)
                return
            }
            guard let data = data else { return }
            
            do {
                // parse resulting data and remove first 5 charecters based on Udacity request
                let decoder = JSONDecoder()
                results  = try decoder.decode(LoginResults.self, from: data.dropFirst(5))
                success = true
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
                success = false
            }
            // return results
            completion(results ?? LoginResults(),success)
        }
        task.resume()
    }
    
    // Mark: logout method
    func logout(completion: @escaping (Bool)->()){
        //set url request
        let url = URL(string: baseURL + methodName.session.rawValue)
        //set Url Request properaties
        var request = URLRequest(url: url!)
        request.httpMethod = methodType.logout.rawValue
        //set cookie
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        //validate login by sending data
        let task = sharedSession.dataTask(with: request ) { ( data, _, err)  in
            DispatchQueue.main.async {
                var success = false
                //check if the request success
                if let err = err {
                    print("Failed to get data from url:", err)
                    success = false
                    return
                }
                guard let data = data else { return }
                
                do {
                    // parse resulting data and remove first 5 charecters based on Udacity request
                    try JSONDecoder().decode(LoginResults.self, from: data.dropFirst(5))
                    success = true
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    success = false
                }
                // return results
                completion(success)
            }
        }
        task.resume()
    }
    
    // Mark: get user method
    func getUser(_ userId: String,completion: @escaping (StudentInformation, Bool)->()){
        //set url request
        let url = URL(string: baseURL + methodName.users.rawValue + userId)
        //set Url Request properaties
        var request = URLRequest(url: url!)
        request.httpMethod = methodType.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(String(describing: udacitySession?.id))", forHTTPHeaderField: "Authorization")
        //validate login by sending data
        let task = sharedSession.dataTask(with: request ) { ( data, _, err)  in
            DispatchQueue.main.async {
                var results : StudentInformation?
                var success = false
                //check if the request success
                if let err = err {
                    print("Failed to get data from url:", err)
                    success = false
                    return
                }
                guard let data = data else { return }
                
                do {
                    // parse resulting data and remove first 5 charecters based on Udacity request
                    results  = try JSONDecoder().decode(StudentInformation.self, from: data.dropFirst(5))
                    success = true
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    success = false
                }
                // return results
                completion(results ?? StudentInformation(),success)
            }
        }
        task.resume()
    }
}
