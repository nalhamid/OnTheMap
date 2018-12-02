//
//  setActivityIndicator.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 25/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

extension UIViewController {
    // Mark: setActivityIndicator
    func setActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
}


