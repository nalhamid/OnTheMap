//
//  textfieldY.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 01/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

extension UIViewController {
    // Mark: setTextfieldY
    func setTextfieldY(_ textfieldY: CGFloat){
        // app delegate for textfields
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.textfieldY = textfieldY
    }
    // Mark: getTextfieldY
    func getTextfieldY() -> CGFloat {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.textfieldY ?? 0
    }
}
