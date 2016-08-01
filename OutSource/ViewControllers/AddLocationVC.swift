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
import Material

class AddLocationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var interestTextField: TextField!
    @IBOutlet weak var descriptionTextView: TextView!
    @IBOutlet weak var imageView: UIImageView!
    
    let locationManager = CLLocationManager()
    let firebaseHelper = FirebaseHelper()
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddLocationVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func addImageButtonTapped(sender: FabButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    

    
    @IBAction func addButtonTapped(sender: FabButton) {
        //Its kinda messy, but it adds new posts
        firebaseHelper.currentUser { user in
            let imageID = NSUUID().UUIDString
            let imageStorageRef = self.firebaseHelper.storageRef.child((FIRAuth.auth()?.currentUser?.uid)!).child(imageID)
            
            let localImage = UIImageJPEGRepresentation(self.imageView.image!, 0.9)
            
            let upload = imageStorageRef.putData(localImage!, metadata: nil) { metadata, error in
                if (error != nil) {
                        
                } else {
                        
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let newPost = Post(title: self.titleTextField.text!, description: self.descriptionTextView.text!, interest: self.interestTextField.text!, longitude: self.locationManager.location!.coordinate.longitude.description, latitude: self.locationManager.location!.coordinate.latitude.description, user: user.UID!, imageID: "\(user.UID!)/\(imageID)")
                    
                    newPost.uploadPost()
                    
                    
                }
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            
        
            
        }
    }
}
