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
    var title: String?
    var description: String?
    let interest: String?
    let longitude: String?
    let latitude: String?
    let user: String?
    
    init(title: String?, description: String?, interest: String?, longitude: String?, latitude: String?, user: String?){
        self.longitude = longitude
        self.latitude = latitude
        self.title = title
        self.description = description
        self.interest = interest
        self.user = user
    }
    
    func uploadPost(){
        let postInfo: Dictionary<String, String> = ["title": self.title! ,
                                                    "description": self.description!,
                                                    "user": self.user!,
                                                    "interest": self.interest!,
                                                    "longitude": self.longitude!,
                                                    "latitude": self.latitude!]
        
        self.firebaseHelper.postRef.childByAutoId().setValue(postInfo)
    }
    
}
