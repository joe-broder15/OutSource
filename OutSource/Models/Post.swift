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
    let imageID: String?
    let uid: String?
    let timeLimit: Double?
    
    init(title: String?, description: String?, interest: String?, longitude: String?, latitude: String?, user: String?, imageID: String?, uid: String?, timeLimit: Double?){
        self.longitude = longitude
        self.latitude = latitude
        self.title = title
        self.description = description
        self.interest = interest
        self.user = user
        self.imageID = imageID
        self.uid = uid
        self.timeLimit = (timeLimit! * 3600) + (NSDate().timeIntervalSince1970 as Double)
    }
    
    func uploadPost(){
        
        print("uploading")
        
        let postInfo: Dictionary<String, AnyObject> = ["title": self.title! ,
                                                    "description": self.description!,
                                                    "user": self.user!,
                                                    "interest": self.interest!,
                                                    "longitude": self.longitude!,
                                                    "latitude": self.latitude!,
                                                    "timeLimit": self.timeLimit!,
                                                    "imageID": self.imageID!,
                                                    "uid": self.uid!]
        
        
        self.firebaseHelper.postRef.child(self.uid!).setValue(postInfo)
    }
    
}
