//
//  FirebaseHelper.swift
//  OutSource
//
//  Created by JoeB on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelper {
    
    //refs to keep things organized
    let rootRef = FIRDatabase.database().referenceFromURL("https://out-source-d85e3.firebaseio.com/")
    
    
    
    
    
    
    
}

extension FirebaseHelper {
    
    //Will create a new user in code and auth
    func createNewUser(newUserEmail: String, newUserPassword: String, newUserUserName: String){
        
        //This is the part where we create the user in authentication
        FIRAuth.auth()?.createUserWithEmail(newUserEmail, password: newUserPassword) { (user, error) in
            
            //here in the callback we will create the user in code as well
            let newUser = User(email: newUserEmail, password: newUserPassword, userName: newUserUserName)
            
            //we add that user object to the database
            self.rootRef.child("Users").child(newUser.userName)
        }
    }
}


