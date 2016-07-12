//
//  SignUpVC.swift
//  OutSource
//
//  Created by JoeB on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Material

class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonPressed(sender: RaisedButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
