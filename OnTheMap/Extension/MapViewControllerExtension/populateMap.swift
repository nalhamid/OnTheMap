//
//  populateMap.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 01/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit
// Import map kit
import MapKit

extension MapViewController{
    // Mark: populate map
    func populateMap(){
        //get student list
        let studentsLocations = locationModel.getLocationList()
        // array of map annotations
        var annotations = [MKPointAnnotation]()
        //loop student locations
        for studentLocation in studentsLocations {
            //set latitude and longitude
            let lat = CLLocationDegrees(studentLocation.latitude!)
            let long = CLLocationDegrees(studentLocation.longitude!)
            //The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            //get student info
            let firstName = studentLocation.firstName ?? ""
            let lastName = studentLocation.lastName ?? ""
            let fullName = firstName + "" + lastName
            let studentUrl = studentLocation.mediaURL ?? "https://udacity.com"
            // create the annotation and set its coordiate and student info
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = fullName
            annotation.subtitle = studentUrl
            // place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        //remove annotations from the map
        self.mapView.removeAnnotations(annotations)
        //add the annotations to the map
        self.mapView.addAnnotations(annotations)
    }
}
