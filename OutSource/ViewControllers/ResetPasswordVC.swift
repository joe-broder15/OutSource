//
//  ResetPasswordVC.swift
//  OutSource
//
//  Created by JoeB on 9/1/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import Toast_Swift
import Material
import SwiftSpinner

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var emailField: TextField!
    
    let firebaseHelper = FirebaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.font = UIFont(name: "Open Sans", size: 20)
        self.emailField.textColor = UIColor.whiteColor()
        self.emailField.placeholderColor = UIColor.whiteColor()
        self.emailField.placeholderActiveColor = UIColor.whiteColor()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func resetButtonTapped(sender: AnyObject) {
        if self.emailField.text == "" {
            self.view.makeToast("Please enter a valid email")
        } else {
            SwiftSpinner.show("Sending Link")
            FIRAuth.auth()?.sendPasswordResetWithEmail(emailField.text!, completion: { error in
                SwiftSpinner.hide()
                self.view.makeToast("An reset link has been sent to your email", duration: 3.0, position: .Bottom)
                self.emailField.text = ""
            })
        }
        
        
    }
}

//MARK: Tap out of keyboard
extension ResetPasswordVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ResetPasswordVC {
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}