//
//  User.swift
//  OutSource
//
//  Created by JoeB on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

class User {
    var email: String
    var password: String
    var userName: String
    
    init(email: String, password: String, userName: String) {
        
        self.email = email
        self.password = password
        self.userName = userName
    }
    
}
