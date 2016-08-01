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
    let storageRef = FIRStorage.storage().reference()
    
    //Returns the current user with a callback
    func currentUser(completionHandler: (User) -> Void){
        
        //create the user
        let user = User(email: FIRAuth.auth()?.currentUser?.email, userName: FIRAuth.auth()?.currentUser?.displayName, UID: FIRAuth.auth()?.currentUser?.uid, interests: nil)
        
        //make an array to become the interest value
        var interestList = [String]?()
        
        //Get the interests
        self.ref.child("Users").child(user.UID!).child("interests").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) -> Void in
            
            //Get interests and reset the user's value
            interestList = snapshot.value as? [String]
            user.interests = interestList
            
            //go into the completion block
            completionHandler(user)
            
        })
    }
    
    func loadPosts(user: User, completionHandler: (Post) -> Void){
        
        // Listen for new messages in the Firebase database
        self.ref.child("Posts").observeEventType(FIRDataEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            
            //get the value of the snapshot
            let postVal = snapshot.value! as! Dictionary<String, AnyObject>
            
            //Deletes values if they are old
            if (NSDate().timeIntervalSince1970 as Double) - (postVal["timeStamp"] as! Double)  > 86400{
                
                self.storageRef.child((postVal["imageID"] as? String)!).deleteWithCompletion { (error) -> Void in
                    if (error != nil) {
                        print(error?.description)
                    } else {
                        // File deleted successfully
                    }
                }
                self.ref.child("Posts").child(snapshot.key).removeValue()
                
                
            } else {
                //otherwise we create a post and go to the callback
                if user.interests!.contains(postVal["interest"]! as! String){
                    let matchedPost = Post(title: postVal["title"] as? String,
                        description: postVal["description"] as? String,
                        interest: postVal["interest"] as? String,
                        longitude: postVal["longitude"] as? String,
                        latitude: postVal["latitude"] as? String,
                        user: postVal["user"] as? String,
                        imageID: postVal["imageID"] as? String)
                    
                    //callback
                    completionHandler(matchedPost)
                
                
                }
            }
        })
    }
}
