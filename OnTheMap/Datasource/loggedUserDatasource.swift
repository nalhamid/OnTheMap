//
//  loggedUserDatasource.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 03/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

// Mark: studentsDatasource
class loggedUserDatasource {
    // seassion ID
    var udacitySession : session? = nil
    // studentInformation
    var studentInformation = StudentInformation ()
    // user state
    var isLoggedIn = false
    // current user info
    var loggedUser = StudentLocation()
    // set default value to location exist
    var locationExist = false
    //shared instance
    class func sharedInstance() -> loggedUserDatasource{
        struct Singleton {
            static var sharedInstance = loggedUserDatasource()
        }
        return Singleton.sharedInstance
    }
}
