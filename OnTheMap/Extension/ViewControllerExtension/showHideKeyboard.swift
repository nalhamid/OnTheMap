//
//  showHideKeyboard.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 24/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
// source: https://www.youtube.com/watch?v=AiYCStoj0lc

import UIKit

extension UIViewController {
    
    // mark: keyboardWillShow
    @objc func keyboardWillShow(_ notification:Notification) {
        //get key board Height
        let keyboardHeight = getKeyboardHeight(notification)
        // get key board postions
        let keyboardY = self.view.frame.size.height - keyboardHeight
        // text y postion
        let textfieldY = getTextfieldY()
        //check if the field behind keyboard
        if textfieldY > keyboardY - 60 {
            //move up with keyboaed size
            view.frame.origin.y = 0
            view.frame.origin.y -= textfieldY - (keyboardHeight - 60)
        }
    }
    
    // mark: keyboardWillHide
    @objc func keyboardWillHide(_ notification:Notification) {
        //set back to zero
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        return (keyboardSize.cgRectValue.height)
    }
    
    // mark: subscribeToKeyboardNotifications
    func subscribeToKeyboardNotifications() {
        //subscribe To Keyboard will show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //subscribe To Keyboard will hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // mark: unsubscribeFromKeyboardNotifications
    func unsubscribeFromKeyboardNotifications() {
        //unsubscribe To Keyboard will show
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        //unsubscribe To Keyboard will hide
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
