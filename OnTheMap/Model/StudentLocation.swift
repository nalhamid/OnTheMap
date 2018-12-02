//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 13/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

// Mark: StudentLocation struct for ParseAPI Json
struct StudentLocation: Codable {
    var objectId: String?
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Float?
    var longitude: Float?
    var createdAt: String?
    var updatedAt: String?
    var ACL: String?
}

// Mark: locations list
struct StudentList : Codable{
    var results : [StudentLocation] = []
}
