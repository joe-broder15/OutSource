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
    let imageLink: String?
    
    init(title: String?, description: String?, interest: String?, longitude: String?, latitude: String?, user: String?, imageLink: String?){
        self.longitude = longitude
        self.latitude = latitude
        self.title = title
        self.description = description
        self.interest = interest
        self.user = user
        self.imageLink = imageLink
    }
    
    func uploadPost(){
        
        let postInfo: Dictionary<String, AnyObject> = ["title": self.title! ,
                                                    "description": self.description!,
                                                    "user": self.user!,
                                                    "interest": self.interest!,
                                                    "longitude": self.longitude!,
                                                    "latitude": self.latitude!,
                                                    "timeStamp": NSDate().timeIntervalSince1970 as NSNumber,
                                                    "imageLink": self.imageLink!]
        
        self.firebaseHelper.postRef.childByAutoId().setValue(postInfo)
    }
    
}
