//
//  loginTextfieldDelegate.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 25/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit


// text fields methods
extension LoginViewController : UITextFieldDelegate {
    // Mark: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //check if fields empty
        if usernameTextfield.text == "" || passwordTextfield.text == "" {
            enableLogin(false)
        }else {
            enableLogin(true)
        }
        return true
    }
    // Mark: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //go to next button
        switch textField {
        case usernameTextfield:
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            passwordTextfield.resignFirstResponder()
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

