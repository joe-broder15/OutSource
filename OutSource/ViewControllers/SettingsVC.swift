//
//  SettingsVC.swift
//  OutSource
//
//  Created by JoeB on 8/1/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit
import Material
import Firebase

class SettingsVC: UIViewController{
    
    override func viewDidLoad() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat", size: 24)!]
    }
    
    
    @IBAction func interestButtonTapped(sender: FlatButton) {
        self.performSegueWithIdentifier("settingsToInterestsSegue", sender: self)
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signoutTapped(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "checkUser")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userPass")
        self.performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
    @IBAction func cancelToSettings(segue:UIStoryboardSegue) {
    }
}

extension SettingsVC {
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}