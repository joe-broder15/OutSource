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
import Toast_Swift


class SignUpVC: UIViewController {
    //Text fields
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var pwField: TextField!
    @IBOutlet weak var pwField2: TextField!
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
        
        self.pwField2.font = UIFont(name: "Open Sans", size: 20)
        self.pwField2.textColor = UIColor.whiteColor()
        self.pwField2.placeholderColor = UIColor.whiteColor()
        self.pwField2.placeholderActiveColor = UIColor.whiteColor()
        self.pwField2.secureTextEntry = true
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(sender: FlatButton) {
        
        let email = self.emailField.text
        let userName = self.userNameField.text
        let password = self.pwField.text
        let password2 = self.pwField2.text
        
        //if password is under 6 characters return
        if email == "" {
            self.view.makeToast("Email is empty", duration: 1.0, position: .Bottom)
        } else if userName == "" {
            self.view.makeToast("Username is empty", duration: 1.0, position: .Bottom)
        } else if password == "" {
            self.view.makeToast("Password is empty", duration: 1.0, position: .Bottom)
        } else if password2 == "" {
            self.view.makeToast("Must verify Password", duration: 3.0, position: .Bottom)
        } else if password != password2 {
            self.view.makeToast("Passwords do not match", duration: 1.0, position: .Bottom)
        } else if password!.characters.count < 6 {
            self.view.makeToast("Password is under 7 characters", duration: 1.0, position: .Bottom)
        } else {
            self.performSegueWithIdentifier("signupToTermsSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "signupToTermsSegue" {
                let vc = segue.destinationViewController as! TermsVC
                vc.email = self.emailField.text!
                vc.userName = self.userNameField.text!
                vc.password = self.pwField.text!
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

extension SignUpVC {
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}
