//
//  showAddView.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 28/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

extension UIViewController{
    // Mark: showAddView
    func showAddView(){
        // go to add location
        let addNavigationController : UINavigationController
        addNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "addNavigationController") as! UINavigationController
        self.present(addNavigationController, animated: true)
    }
}
