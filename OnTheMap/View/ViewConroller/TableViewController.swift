//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 07/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

class TableViewController: UIViewController{
    // table view outlet
    @IBOutlet weak var tableView: UITableView!
    //view model connect
    var locationModel = StudentLocationViewModel()
    // Mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // call Navigation Settings
        setNavigations()
    }
}

