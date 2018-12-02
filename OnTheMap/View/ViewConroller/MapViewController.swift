//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 07/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit
// Import map kit
import MapKit

class MapViewController: UIViewController {
    //set map outlet
    @IBOutlet weak var mapView: MKMapView!
    //view model connect
    var locationModel = StudentLocationViewModel()
    // Mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // call Navigation Settings
        setNavigations()
        // populate map
        populateMap()
    }
}

