//
//  SignUpVC.swift
//  OutSource
//
//  Created by JoeB on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Material
import Foundation
import Firebase

class SignUpVC: UIViewController {
    //Text fields
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var displayNameTextField: TextField!
    
    let rootRef = FIRDatabase.database().referenceFromURL("https://out-source-d85e3.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonPressed(sender: RaisedButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(sender: RaisedButton) {
        
        let email = self.emailTextField.text
        let userName = self.displayNameTextField.text
        let password = self.passwordTextField.text
        
        //if password is under 6 characters return
        if password!.characters.count < 6 {
            return
        }
        
        //if there is text in all feilds, make a new user
        if password != nil && userName != nil && email != nil {
            
            //This is the part where we create the user in authentication
            FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
                
                //sign into the user we just created
                FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
                    
                    //update the username of the current user in auth
                    let currentUser = FIRAuth.auth()?.currentUser

                    //here in the callback we will create the user in code as well
                    let userData: Dictionary<String, String>  = ["email": (currentUser?.email!)!, "password": password!, "username": userName!]//, "interests":["placeholder"]]
                    
                    //we add that user object to the database
                    self.rootRef.child("Users").child((currentUser?.uid)!).setValue(userData)
                    print(userData)
                    
                }
            }
            
            performSegueWithIdentifier("toInterestsSegue", sender: self)
            
        } else {
            return
        }
    }
}
