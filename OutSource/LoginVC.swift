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
import Firebase

class LoginVC: UIViewController, TextFieldDelegate {
    
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var pwField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        pwField.delegate = self
      
        
    }
    @IBAction func loginButtonPressed(sender: RaisedButton) {
        FIRAuth.auth()?.signInWithEmail(self.emailField.text!, password: self.pwField.text!) { (user, error) in
            
            if error != nil {
                print("ERROR CODE 2: CREDENTIALS NOT RECOGNIZED")
            } else {
                self.performSegueWithIdentifier("signInToMapSegue", sender: self)
            }
            
        }
    }
}
