//
//  FirebaseHelper.swift
//  OutSource
//
//  Created by JoeB on 7/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class FirebaseHelper {
    let rootRef = FIRDatabase.database().referenceFromURL("https://out-source-d85e3.firebaseio.com/")
    let postRef = FIRDatabase.database().referenceFromURL("https://out-source-d85e3.firebaseio.com/Posts")
    let usersRef = FIRDatabase.database().referenceFromURL("https://out-source-d85e3.firebaseio.com/Users")
    let interestRef = FIRDatabase.database().referenceFromURL("https://out-source-d85e3.firebaseio.com/Interests")
    var currentUserAuth = FIRAuth.auth()?.currentUser
    var _refHandle: FIRDatabaseHandle!
    let ref = FIRDatabase.database().reference()
    
    func currentUser(completionHandler: (User) -> Void){
        
        var user = User(email: FIRAuth.auth()?.currentUser?.email, userName: FIRAuth.auth()?.currentUser?.displayName, UID: FIRAuth.auth()?.currentUser?.uid, interests: nil)
        
        var interestList = [String]?()
        
        self.ref.child("Users").child(user.UID!).child("interests").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) -> Void in
            
            print("Setting interests")
            interestList = snapshot.value as? [String]
            print(interestList)
            user.interests = interestList
            
            completionHandler(user)
            
        })
    }
    
    func loadPosts(user: User, completionHandler: (Post) -> Void){
        
        // Listen for new messages in the Firebase database
        self.ref.child("Posts").observeEventType(FIRDataEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            
            //get the value of the snapshot
            let postVal = snapshot.value! as! Dictionary<String, String>
            
            if user.interests!.contains(postVal["interest"]!){
                let matchedPost = Post(title: postVal["title"],
                    description: postVal["description"],
                    interest: postVal["interest"],
                    longitude: postVal["longitude"],
                    latitude: postVal["latitude"],
                    user: postVal["user"])
                
                completionHandler(matchedPost)
                
                
            }
        })
    }
}
