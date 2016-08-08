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

class SettingsVC: UIViewController{
    
    override func viewDidLoad() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat", size: 24)!]
    }
    
    
    @IBAction func interestButtonTapped(sender: FlatButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}