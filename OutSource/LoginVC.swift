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
import SwiftSpinner

class LoginVC: UIViewController, TextFieldDelegate {
    
    //let firebaseHelper = FirebaseHelper()
    
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var pwField: TextField!
    @IBOutlet weak var loginBtn: RaisedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().boolForKey("checkUser") == true {
            
            FIRAuth.auth()?.signInWithEmail(NSUserDefaults.standardUserDefaults().objectForKey("userEmail") as! String, password: NSUserDefaults.standardUserDefaults().objectForKey("userPass") as! String) { (user, error) in
                if error != nil {
                    print(error?.description)
                    return
                } else {
                    self.performSegueWithIdentifier("signInToMapSegue", sender: self)
                }
            }
        }
        
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "uid")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "checkUid")
        
        emailField.delegate = self
        pwField.delegate = self
        hideKeyboardWhenTappedAround()
        
        self.emailField.font = UIFont(name: "Open Sans", size: 20)
        self.emailField.textColor = UIColor.whiteColor()
        self.emailField.placeholderColor = UIColor.whiteColor()
        self.emailField.placeholderActiveColor = UIColor.whiteColor()
        
        self.pwField.font = UIFont(name: "Open Sans", size: 20)
        self.pwField.textColor = UIColor.whiteColor()
        self.pwField.placeholderColor = UIColor.whiteColor()
        self.pwField.placeholderActiveColor = UIColor.whiteColor()
        self.pwField.secureTextEntry = true
        
        
      
        
    }
    @IBAction func loginButtonPressed(sender: RaisedButton) {
        //logs in the user
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: pwField.text!) { (user, error) in
            if error != nil {
                print(error?.description)
                return
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "checkUser")
                NSUserDefaults.standardUserDefaults().setObject(self.emailField.text!, forKey: "userEmail")
                NSUserDefaults.standardUserDefaults().setObject(self.pwField.text!, forKey: "userPass")
                self.performSegueWithIdentifier("signInToMapSegue", sender: self)
            }
        }
        
        
    }
    
    //QuickLogin
    @IBAction func quickLogin(sender: FlatButton) {
        FIRAuth.auth()?.signInWithEmail("test@test.xyz", password: "1234567") { (user, error) in
            if error != nil {
                print(error?.description)
                return
            } else {
                self.performSegueWithIdentifier("quickLoginSegue", sender: self)
            }
        }
    }
    
}

//MARK: Tap out of keyboard
extension LoginVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginVC {
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}
