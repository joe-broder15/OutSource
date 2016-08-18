//
//  User.swift
//  OutSource
//
//  Created by JoeB on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

class User {
    var email: String?
    var userName: String?
    var UID: String?
    var interests: [String]?
    var blocked: Dictionary<String, String>?
    
    
    init(email: String?, userName: String?, UID: String?, interests: [String]?, blocked: Dictionary<String, String>?) {
        self.email = email
        self.userName = userName
        self.UID = UID
        self.interests = interests
        self.blocked = blocked
    }
    
    

}