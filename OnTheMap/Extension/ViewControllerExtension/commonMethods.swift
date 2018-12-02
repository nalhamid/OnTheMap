//
//  commonMethods.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 25/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

// Mark: Navigation Button Actions
extension UIViewController {
    

    // Mark: add location function
    func addStudentLocationCommon(){
        // model connect
        let locationModel = StudentLocationViewModel()
        locationModel.isUserLocationExist{exist in
            if(exist){
                //show alert with overwrite function
                self.addLocationAlert()
            }else{
                self.showAddView()
            }
        }
    }
    // Mark: refresh list function
    func refreshLocationsListCommon(completion: @escaping (Bool)->()){
        // activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        // model connect
        let locationModel = StudentLocationViewModel()
        //set Activity Indicator
        setActivityIndicator(activityIndicator: activityIndicator)
        //start Animating
        activityIndicator.startAnimating()
        //call get list
        locationModel.getStudentLocationsList{ success in
                if(!success){
                    self.showAlertExtension(title: "Unable to Connect", message: "Unable to get data. please check your connection and try again")
                }
                //stop Animating
                activityIndicator.stopAnimating()
            completion(success)
        }
    }
    // Mark: logout function
    func logoutUserCommon(){
        let userViewModel = UserViewModel()
        //call login method
        userViewModel.logout{ success in
            DispatchQueue.main.async {
                if(success){
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    
                } else {
                    self.showAlertExtension(title: "Logout failed", message: "Please try again")
                }
            }
        }
    }
}
