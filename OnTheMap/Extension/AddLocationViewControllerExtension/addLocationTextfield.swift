//
//  addLocationTextfield.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 01/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

extension AddLocationViewController: UITextFieldDelegate{
    // Mark: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //check if fields empty
        if locationTextfield.text == "" || linkTextfield.text == "" {
            enablefinishButton(false)
        }else {
            enablefinishButton(true)
        }
        return true
    }
    // Mark: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //go to next button
        switch textField {
        case locationTextfield:
            linkTextfield.becomeFirstResponder()
        case linkTextfield:
            linkTextfield.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    // mark: textFieldShouldBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // assign textfieldY the Application Delegate
        setTextfieldY(textField.frame.origin.y)
        //subscribeToKeyboardNotifications to move view
        subscribeToKeyboardNotifications()
    }
    // Mark: textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
        // assign textfieldY the Application Delegate
        setTextfieldY(0)
        //unsubscribeToKeyboardNotifications to move back view
        unsubscribeFromKeyboardNotifications()
    }
}
