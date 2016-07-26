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
    
    func currentUser(completionHandler: (User) -> Void ){
        
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
    
//    func loadPosts() -> [Post] {
//        
//        let user = self.currentUser()
//        var interestedPosts = [Post]()
//        
//        // Listen for new messages in the Firebase database
//        _refHandle = self.postRef.observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
//            
//            //get the value of the snapshot
//            let postVal = snapshot.value as! Dictionary<String, String>
//            
//            //create a post object with the snapshot
//            let post = Post(title: postVal["title"], description: postVal["description"], interest: postVal["interest"], longitude: postVal["longitude"], latitude: postVal["latitude"], user: postVal["user"])
//            
//            print("created post")
//            
//            if the interest of the snapshot is equal to one of the user interests, append it to the interested posts
//            for i in user.interests {
//                if i == post.interest{
//                    interestedPosts.append(post)
//                    print("MATCH")
//                }else{
//                    print("no match")
//                }
//            }
//        })
//        //print(user.interests)
//        return interestedPosts
//    }
}
