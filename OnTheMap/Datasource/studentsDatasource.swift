//
//  studentsDatasource.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 03/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import Foundation

// Mark: studentsDatasource
class studentsDatasource {
    // list of student location
    var studentList = StudentList()
    //shared instance
    class func sharedInstance() -> studentsDatasource{
        struct Singleton {
            static var sharedInstance = studentsDatasource()
        }
        return Singleton.sharedInstance
    }
}
