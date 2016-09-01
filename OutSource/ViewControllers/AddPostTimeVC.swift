//
//  AddPostTimeVC.swift
//  OutSource
//
//  Created by JoeB on 8/31/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import Firebase
import SwiftSpinner
import UIKit
import Material
import Toast_Swift
import CoreLocation

class AddPostTimeVC: UIViewController {
    
    var postInterest = String()
    var postImage = UIImage()
    var postTime = Double()
    var postTitle = String()
    var postDescription = String()
    let firebaseHelper = FirebaseHelper()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var timeCounterLabel: UILabel!
    
    override func viewDidLoad() {
        self.postTime = 3
        timeCounterLabel.text = String(self.postTime)
    }
    
    @IBAction func timeAddButtonTapped(sender: AnyObject) {
        if self.postTime == 24 {
            view.makeToast("Time must be under 24 hours")
        } else {
            self.postTime += 1
            self.timeCounterLabel.text = String(self.postTime)
        }
        
    }
    @IBAction func timeSubtractButtonTapped(sender: AnyObject) {
        if postTime == 1 {
            return
        } else {
            self.postTime -= 1
            self.timeCounterLabel.text = String(self.postTime)
        }
        
    }
    
    @IBAction func postButtonTapped(sender: AnyObject) {
        
        
        
        let alert = UIAlertController(title: "Add Shout", message: "This will add a shout at your current location and thus will allow users to see where you are right now.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add Shout", style: .Default, handler: { action in
            
            //Its kinda messy, but it adds new posts
            
            self.firebaseHelper.currentUser { user in
                
                SwiftSpinner.show("Uploading Shout")
                    
                let imageID = NSUUID().UUIDString
                let imageStorageRef = self.firebaseHelper.storageRef.child((FIRAuth.auth()?.currentUser?.uid)!).child(imageID)
                let localImage = UIImageJPEGRepresentation(self.postImage, 0.9)
                    
                let upload = imageStorageRef.putData(localImage!, metadata: nil) { metadata, error in
                    if (error != nil) {
                        print("upload error")
                    } else {
                            
                        // Metadata contains file metadata such as size, content-type, and download URL.
                        let newPost = Post(title: self.postTitle, description: self.postDescription, interest: self.postInterest, longitude: self.locationManager.location!.coordinate.longitude.description, latitude: self.locationManager.location!.coordinate.latitude.description,    user: user.UID!, imageID: "\(user.UID!)/\(imageID)", uid: CFUUIDCreateString(nil, CFUUIDCreate(nil)) as String, timeLimit: self.postTime)
                            
                        print(newPost.timeLimit!)
                        newPost.uploadPost()
                        self.performSegueWithIdentifier("cancelToMap", sender: self)
                        SwiftSpinner.hide()

                            
                            
                    }
                }
                    
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
