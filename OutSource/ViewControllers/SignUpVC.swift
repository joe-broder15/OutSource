//
//  SignUpVC.swift
//  OutSource
//
//  Created by JoeB on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Material
import Firebase

class SignUpVC: UIViewController {
    //Text fields
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var displayNameTextField: TextField!
    
    let firebaseHelper = FirebaseHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonPressed(sender: RaisedButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(sender: RaisedButton) {
        firebaseHelper.createNewUser(emailTextField.text!, newUserPassword: passwordTextField.text!, newUserUserName: displayNameTextField.text!)
        //performSegueWithIdentifier("signUpToMapSegue", sender: self)
        
        
    }
    
    
}
