//
//  User.swift
//  OutSource
//
//  Created by JoeB on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

struct User {
    var email: String?
    var userName: String?
    var UID: String?
    var interests: [String]?
    
    init(email: String?, userName: String?, interests: [String]?, UID: String?) {
        self.email = email
        self.userName = userName
        self.interests = interests
        self.UID = UID
    }
    
    

}
