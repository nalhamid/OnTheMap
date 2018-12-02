//
//  mapMethods.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 30/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//
import UIKit

extension MapViewController{
    // Mark: set Navigation Buttons
    func setNavigations (){
        // set title
        title = "On The Map"
        //add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStudentLocation))
        //refresh button
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh , target: self, action: #selector(refreshLocationsList))
        self.navigationItem.rightBarButtonItems = [addButton, refreshButton]
        //logout button
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        self.navigationItem.leftBarButtonItem = logoutButton
    }
    // Mark: add location function
    @objc func addStudentLocation(){
        // model connect
        addStudentLocationCommon()
    }
    // Mark: refresh list function
    @objc func refreshLocationsList(){
        refreshLocationsListCommon(){success in
         self.populateMap()
        }
    }
    // Mark: logout function
    @objc func logoutUser(){
        logoutUserCommon()
    }
}

