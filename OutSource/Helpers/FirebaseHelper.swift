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
    private var _refHandle: FIRDatabaseHandle!
    var ref: FIRDatabaseReference!
    //var firPosts: [AnyObject] = []
    
    var currentUser = User(email: nil, userName: nil, interests: nil, UID: nil)
    
    init(){
        //Sets the user info
        if let user = FIRAuth.auth()?.currentUser {
            for profile in user.providerData {
                self.currentUser.UID = profile.uid
                self.currentUser.userName = profile.displayName
                self.currentUser.email = profile.email
            }
        } else {
            print("No user signed in")
        }
        
        _refHandle = self.usersRef.child(self.currentUser.UID!).child("interests").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            //let pos
        })
    }
    
    func loadPosts() {
        ref = FIRDatabase.database().reference()
        
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("Posts").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            //let postval = snapshot.value!
        })
    }
}
