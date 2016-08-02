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
    
    //let firebaseHelper = FirebaseHelper()
    
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var pwField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        pwField.delegate = self
      
        
    }
    @IBAction func loginButtonPressed(sender: RaisedButton) {
        //logs in the user
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: emailField.text!) { (user, error) in
            if error != nil {
                print(error?.description)
                return
            } else {
                self.performSegueWithIdentifier("signInToMapSegue", sender: self)
            }
        }
    }
    
    //QuickLogin
    @IBAction func quickLogin(sender: FlatButton) {
        FIRAuth.auth()?.signInWithEmail("test@test.com", password: "1234567") { (user, error) in
            if error != nil {
                print(error?.description)
                return
            } else {
                self.performSegueWithIdentifier("quickLoginSegue", sender: self)
            }
        }
    }
    
}

