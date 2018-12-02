//
//  findLocationMapDelegate.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 02/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit
//import map kit
import MapKit

extension FindLocationViewController : MKMapViewDelegate{
    // Mark: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // set pin settings
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    // Mark: getCoordinate
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        // decode string address to Coordinat
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            print(error!)
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    // Mark: addPinToMapView
    func addPinToMapView(pinLocation: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        //center on pin
        self.mapView.region = MKCoordinateRegion(center: pinLocation, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = pinLocation
        annotation.title = self.location
        //add pin to the map
        self.mapView.addAnnotation(annotation)
        pinCordinates = annotation
    }
}

