//
//  cancelAddLocaton.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 29/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

extension AddLocationViewController{
    // Mark: cancelButton
    func cancelButtonAdd(){
        //cancel button
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAdd))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func cancelAdd(){
        self.dismiss(animated: true, completion: nil)
    }
}
