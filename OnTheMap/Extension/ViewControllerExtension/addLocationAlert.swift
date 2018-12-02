//
//  addLocationAlert.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 28/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

extension UIViewController {
    // show alert message
    func addLocationAlert(){
        let controller = UIAlertController()
        //set alert message
        controller.title = "Location Exist"
        controller.message = "There is a Location added for you. do you want to overwrite it?"
        //set overwriteAction Button
        let overwriteAction = UIAlertAction(title: "Overwrite", style: UIAlertAction.Style.default){ action in
            // dismiss alert
            //self.dismiss(animated: true, completion: nil)
            // go to add location
            self.showAddView()
        }
        controller.addAction(overwriteAction)
        //set cancelAction Button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel){ action in
            //  self.dismiss(animated: true, completion: nil)
        }
        controller.addAction(cancelAction)
        // show message
        present(controller, animated: true, completion: nil)
    }
}
