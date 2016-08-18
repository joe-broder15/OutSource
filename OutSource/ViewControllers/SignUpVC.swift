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
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var pwField: TextField!
    @IBOutlet weak var userNameField: TextField!
    
    let firebaseHelper = FirebaseHelper()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.font = UIFont(name: "Open Sans", size: 20)
        self.emailField.textColor = UIColor.whiteColor()
        self.emailField.placeholderColor = UIColor.whiteColor()
        self.emailField.placeholderActiveColor = UIColor.whiteColor()
        
        self.userNameField.font = UIFont(name: "Open Sans", size: 20)
        self.userNameField.textColor = UIColor.whiteColor()
        self.userNameField.placeholderColor = UIColor.whiteColor()
        self.userNameField.placeholderActiveColor = UIColor.whiteColor()
        
        self.pwField.font = UIFont(name: "Open Sans", size: 20)
        self.pwField.textColor = UIColor.whiteColor()
        self.pwField.placeholderColor = UIColor.whiteColor()
        self.pwField.placeholderActiveColor = UIColor.whiteColor()
        self.pwField.secureTextEntry = true
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(sender: FlatButton) {
        
        let email = self.emailField.text
        let userName = self.userNameField.text
        let password = self.pwField.text
        
        //if password is under 6 characters return
        if password!.characters.count < 6 {
            return
        }
        
        //if there is text in all feilds, make a new user
        if password != nil && userName != nil && email != nil {
            
            //creates a new user object in auth and database
            //This is the part where we create the user in authentication
            FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
                    
                //sign into the user we just created
                FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
                        
                    if error != nil {
                        return
                    } else {
                        
                        //Update the profile username
                        let user = FIRAuth.auth()?.currentUser
                        if let user = user {
                            let changeRequest = user.profileChangeRequest()
                            changeRequest.displayName = userName!
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
                        let userData: Dictionary<String, String>  = ["email": (currentUser?.email!)!, "username": userName!, ]
                            
                        //we add that user object to the database
                        self.firebaseHelper.rootRef.child("Users").child((currentUser?.uid)!).setValue(userData)

                        print(userData)
                        
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "checkUser")
                        NSUserDefaults.standardUserDefaults().setObject(currentUser?.email, forKey: "userEmail")
                        NSUserDefaults.standardUserDefaults().setObject(password!, forKey: "userPass")
                            
                        self.performSegueWithIdentifier("signUpToInterestsSegue", sender: self)
                        
                    }
                }
            }
        }
    }
}
//MARK: Tap out of keyboard
extension SignUpVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

