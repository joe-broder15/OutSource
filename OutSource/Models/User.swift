//
//  User.swift
//  OutSource
//
//  Created by JoeB on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

struct User {
    var email: String
    var password: String
    var userName: String
    var interests: [String]?
    
    init(email: String, password: String, userName: String, interests: [String]?) {
        
        self.email = email
        self.password = password
        self.userName = userName
        self.interests = interests
    }

}
