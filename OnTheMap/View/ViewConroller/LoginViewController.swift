//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 07/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    // Mark: outlets
    @IBOutlet weak var loginButton: BorderedButton!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerText: UITextView!
    //view model connect
    var userViewModel = UserViewModel()
    let locationModel = StudentLocationViewModel()
    // activity Indicator
    let activityIndicator = UIActivityIndicatorView()
    // Mark: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //set Activity Indicator
        setActivityIndicator(activityIndicator: activityIndicator)
        //set delegate
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        //disable login button
        enableLogin(false)
    }
    // Mark: view will load
    override func viewWillAppear(_ animated: Bool) {
        //go to next screen if logged in
        if(userViewModel.getUserState()){
            // go to second screen
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
        //register hyperlink
        hyperlinkText(hyperText: "Sign UP", targetLink: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated", textView: registerText)
    }
    //enable login button
    func enableLogin (_ enable : Bool){
        loginButton.isEnabled = enable
    }
    // Mark: loginButtonPressed
    @IBAction func loginButtonPressed(_ sender: Any) {
        //save login info to covert to json
        userViewModel.saveLogin(username: usernameTextfield.text!, password: passwordTextfield.text!)
        //start Animating
        activityIndicator.startAnimating()
        //call login method
        userViewModel.login{ success, errorMessage in
            DispatchQueue.main.async {
                if(success){
                    // set login state
                    self.userViewModel.userIsLoggedIn(true)
                    // set init user data
                    self.locationModel.setInitUserData()
                    // load locations data
                    self.refreshLocationsListCommon(){ success in
                        if(success){
                            self.activityIndicator.stopAnimating()
                            // go to second screen
                            self.performSegue(withIdentifier: "loginSegue", sender: self)
                        }
                    }
                } else {
                    self.activityIndicator.stopAnimating()
                    // show alert message
                    self.showAlertExtension(title: "Login failed", message: errorMessage)
                }
            }
        }
    }
}
