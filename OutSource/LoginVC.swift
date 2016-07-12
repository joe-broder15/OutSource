//
//  LoginVC.swift
//  OutSource
//
//  Created by JoeB on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit
import Material

class LoginVC: UIViewController, TextFieldDelegate {
    
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var pwField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        pwField.delegate = self
      
        
    }
}
