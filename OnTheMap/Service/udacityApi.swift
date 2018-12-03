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
    func login(_ userLogin: UserLogin,completion: @escaping (LoginResults, Bool, String)->()){
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
        let task = sharedSession.dataTask(with: request ) { data, response, error in
            var results = LoginResults()
            var errorMessage : String = ""
            //  check if the request have an error
            guard (error == nil) else {
                errorMessage = "There was an error with your request: \(error!)"
                completion(results, false, errorMessage)
                return
            }
            // check if the response successful (2XX response)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                let code = (response as? HTTPURLResponse)?.statusCode
                // check for login validation
                if code == 403 {
                    errorMessage = "username or password entered is incorrect. Please try again"
                }
                else {
                    errorMessage = "Your request was not successful. code: \(code!)"
                }
                completion(results, false, errorMessage)
                return
            }
            // check if there any data returned
            guard let data = data else {
                errorMessage = "No data was returned by the request!"
                completion(results, false, errorMessage)
                return
            }
            // parse data
            do {
                // parse resulting data and remove first 5 charecters based on Udacity request
                let decoder = JSONDecoder()
                results  = try decoder.decode(LoginResults.self, from: data.dropFirst(5))
            } catch let jsonErr {
                errorMessage = "Failed to decode data. error: \(jsonErr)"
                completion(results, false, errorMessage)
            }
            // return results
            completion(results, true, errorMessage)
        }
        task.resume()
    }
    
    // Mark: logout method
    func logout(completion: @escaping (Bool, String)->()){
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
        let task = sharedSession.dataTask(with: request ) { ( data, response, error)  in
            DispatchQueue.main.async {
                var errorMessage : String = ""
                //  check if the request have an error
                guard (error == nil) else {
                    errorMessage = "There was an error with your request: \(error!)"
                    completion(false, errorMessage)
                    return
                }
                // check if the response successful (2XX response)
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    let code = (response as? HTTPURLResponse)?.statusCode
                    errorMessage = "Your request was not successful. code: \(code!)"
                    completion(false, errorMessage)
                    return
                }
                // check if there any data returned
                guard let data = data else {
                    errorMessage = "No data was returned by the request!"
                    completion(false, errorMessage)
                    return
                }
                // parse data
                do {
                    // parse resulting data and remove first 5 charecters based on Udacity request
                    try JSONDecoder().decode(LoginResults.self, from: data.dropFirst(5))
                } catch let jsonErr {
                    errorMessage = "Failed to decode data. error: \(jsonErr)"
                    completion(false, errorMessage)
                }
                // return results
                completion(true, errorMessage)
            }
        }
        task.resume()
    }
    
    // Mark: get user method
    func getUser(_ userId: String,completion: @escaping (StudentInformation, Bool, String)->()){
        //set url request
        let url = URL(string: baseURL + methodName.users.rawValue + userId)
        //set Url Request properaties
        var request = URLRequest(url: url!)
        request.httpMethod = methodType.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(String(describing: loggedUserDatasource.sharedInstance().udacitySession?.id))", forHTTPHeaderField: "Authorization")
        //validate login by sending data
        let task = sharedSession.dataTask(with: request ) { ( data, response, error)  in
            DispatchQueue.main.async {
                var results = StudentInformation()
                var errorMessage : String = ""
                //  check if the request have an error
                guard (error == nil) else {
                    errorMessage = "There was an error with your request: \(error!)"
                    completion(results, false, errorMessage)
                    return
                }
                // check if the response successful (2XX response)
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    let code = (response as? HTTPURLResponse)?.statusCode
                    errorMessage = "Your request was not successful. code: \(code!)"
                    completion(results, false, errorMessage)
                    return
                }
                // check if there any data returned
                guard let data = data else {
                    errorMessage = "No data was returned by the request!"
                    completion(results, false, errorMessage)
                    return
                }
                // parse data
                do {
                    // parse resulting data and remove first 5 charecters based on Udacity request
                    results  = try JSONDecoder().decode(StudentInformation.self, from: data.dropFirst(5))
                } catch let jsonErr {
                    errorMessage = "Failed to decode data. error: \(jsonErr)"
                    completion(results, false, errorMessage)
                }
                // return results
                completion(results, true, errorMessage)
            }
        }
        task.resume()
    }
}
