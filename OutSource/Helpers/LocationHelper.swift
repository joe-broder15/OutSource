//
//  LocationHelper.swift
//  OutSource
//
//  Created by JoeB on 7/15/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class LocationHelper{
    
    let locationManager = CLLocationManager()
    
    init(){
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
