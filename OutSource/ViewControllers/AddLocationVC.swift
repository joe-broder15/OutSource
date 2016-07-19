//
//  AddLocationVC.swift
//  OutSource
//
//  Created by JoeB on 7/19/16.
//  Copyright © 2016 Admin. All rights reserved.
//

//import Cocoa
import UIKit
import Firebase
import CoreLocation
import MapKit

class AddLocationVC: UIViewController {
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
