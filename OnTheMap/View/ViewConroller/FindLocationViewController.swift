//
//  FindLocationViewController.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 29/11/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
// source: https://developer.apple.com/documentation/corelocation/converting_between_coordinates_and_user-friendly_place_names

import UIKit
//import map kit
import MapKit

class FindLocationViewController: UIViewController {
    // Mark: outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: BorderedButton!
    // entered variables
    var location: String!
    var link : String!
    var pinCordinates : MKAnnotation!
    //view model connect
    var locationModel = StudentLocationViewModel()
    // activity Indicator
    let activityIndicator = UIActivityIndicatorView()
    // Mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // Mark: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set Activity Indicator
        setActivityIndicator(activityIndicator: activityIndicator)
        //start Animating
        activityIndicator.startAnimating()
        // clear previous annotations
        mapView.removeAnnotations(mapView.annotations)
        //call getCoordinate
        self.getCoordinate(addressString: location!){pinCoordinate, err in
            //check if there are errors
            if let err = err {
                self.showAlertExtension(title: "Unable to find location", message: "couldn't find location. please try again.")
                print(err)
                self.activityIndicator.stopAnimating()
                return
            }
            //add pin to the map
            self.addPinToMapView(pinLocation: pinCoordinate)
            self.activityIndicator.stopAnimating()
        }
    }
    // Mark: finishBtnPressed
    @IBAction func finishBtnPressed(_ sender: Any) {
        // save location to Model
        locationModel.saveLocation(mapString: location, mediaURL: link!, latitude: Float(pinCordinates.coordinate.latitude), longitude: Float(pinCordinates.coordinate.longitude))
        //check if the user have a location
        let LocationState = locationModel.getLocationState()
        if(LocationState){
            // update user location
            locationModel.updateLocation{success, errorMessage in
                if(!success){
                    self.showAlertExtension(title: "Unable to add location", message: errorMessage)
                }
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            // add user location
            locationModel.addLocation{success, errorMessage in
                if(!success){
                    self.showAlertExtension(title: "Unable to add location", message: errorMessage)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

