//
//  Post.swift
//  OutSource
//
//  Created by JoeB on 7/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//


import Foundation
import Firebase
import UIKit
import CoreLocation
import MapKit

class Post {
    let firebaseHelper = FirebaseHelper()
    var locationManager = CLLocationManager()
    var title: String
    var description: String
    //let coordinate = manager.location.coordinate
    let user = FIRAuth.auth()?.currentUser
    let interest: String
    let longitude: String
    let latitude: String
    
    init(title: String, description: String, interest: String){
        self.longitude = locationManager.location!.coordinate.longitude.description
        self.latitude = locationManager.location!.coordinate.latitude.description
        self.title = title
        self.description = description
        self.interest = interest
    }
    
    func uploadPost(){
        let postInfo: Dictionary<String, String> = ["title": self.title ,
                                                    "description": self.description,
                                                    "user": (self.firebaseHelper.currentUser?.uid)!,
                                                    "interest": self.interest,
                                                    "location": self.longitude,
                                                    "latitude": self.latitude]
        
        self.firebaseHelper.postRef.childByAutoId().setValue(postInfo)
    }
    
}
