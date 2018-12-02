//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 29/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    // Mark: outlets
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var linkTextfield: UITextField!
    @IBOutlet weak var findLocationButton: BorderedButton!
    // Mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // disable finish button
        enablefinishButton(false)
        // Mark: cancelButtonAdd
        cancelButtonAdd()
        //set delegate
        locationTextfield.delegate = self
        linkTextfield.delegate = self
    }
    // Mark: enablefinishBtn
    func enablefinishButton (_ enable : Bool){
        findLocationButton.isEnabled = enable
    }
    // Mark: findBtnPressed
    @IBAction func findBtnPressed(_ sender: Any) {
        // go to second screen
        self.performSegue(withIdentifier: "findSegue", sender: self)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check segue
        if segue.identifier == "findSegue" {
             let controller = segue.destination as! FindLocationViewController
            //send values to FindLocationViewController
            controller.location = locationTextfield.text!
            controller.link = linkTextfield.text!
        }
    }
}

