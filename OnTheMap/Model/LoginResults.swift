//
//  LoginResults.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 13/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

struct LoginResults: Codable {
    var currentTime: String?
    var account: account?
    var session: session?
    var currentSecondsSinceEpoch: Float?
    
    enum CodingKeys: String, CodingKey {
        case currentTime = "current_time"
        case account
        case session
        case currentSecondsSinceEpoch = "current_seconds_since_epoch"
    }
    
}

struct account: Codable {
    var registered: Bool?
    var key: String?
}

struct session: Codable {
    var id: String?
    var expiration: String?
}
