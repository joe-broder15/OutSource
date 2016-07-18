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
    
}
