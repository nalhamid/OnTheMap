//
//  userLogin.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 11/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

struct UserLogin: Codable {
    var udacity: authentication
}

struct authentication :Codable{
    var username :String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
