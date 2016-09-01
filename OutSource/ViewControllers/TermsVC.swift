//
//  TermsVC.swift
//  OutSource
//
//  Created by JoeB on 8/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import SwiftSpinner

class TermsVC: UIViewController {
    
    var email: String = ""
    var password: String = ""
    var userName: String = ""
    var fireBaseHelper = FirebaseHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.email)
    }
    
    @IBAction func acceptButtonTapped(sender: AnyObject) {
        
        SwiftSpinner.show("Creating account")
        //creates a new user object in auth and database
        //This is the part where we create the user in authentication
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
            
            //sign into the user we just created
            FIRAuth.auth()?.signInWithEmail(self.email, password: self.password) { (user, error) in
                
                if error != nil {
                    return
                } else {
                    
                    //Update the profile username
                    let user = FIRAuth.auth()?.currentUser
                    if let user = user {
                        let changeRequest = user.profileChangeRequest()
                        changeRequest.displayName = self.userName
                        changeRequest.commitChangesWithCompletion { error in
                            if error != nil {
                                print("Profile not updated")
                            } else {
                                print("Profile updated")
                            }
                        }
                    }
                    
                    //update the username of the current user in auth
                    let currentUser = FIRAuth.auth()?.currentUser
                    
                    //here in the callback we will create the user in code as well
                    let userData: Dictionary<String, String>  = ["email": (currentUser?.email!)!, "username": self.userName, ]
                    
                    //we add that user object to the database
                    self.fireBaseHelper.rootRef.child("Users").child((currentUser?.uid)!).setValue(userData)
                    
                    print(userData)
                    
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "checkUser")
                    NSUserDefaults.standardUserDefaults().setObject(currentUser?.email, forKey: "userEmail")
                    NSUserDefaults.standardUserDefaults().setObject(self.password, forKey: "userPass")
                    
                    self.performSegueWithIdentifier("termsToInterestsSegue", sender: self)
                    
                    
                    
                }
            }
        }
    }
    
    @IBAction func declineButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension TermsVC {
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}