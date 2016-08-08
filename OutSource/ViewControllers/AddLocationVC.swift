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
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImageButton: FabButton!
    @IBOutlet weak var categoryButton: UIButton!
    var postInterest: String? = nil
    
    let locationManager = CLLocationManager()
    let firebaseHelper = FirebaseHelper()
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat-Bold", size: 24)!]
        
        self.descriptionTextView.layer.borderWidth = 2
        self.descriptionTextView.layer.borderColor = self.hexStringToUIColor("#40DE96").CGColor
        
        self.addImageButton.backgroundColor = hexStringToUIColor("#40DE96")
        
        self.titleTextField.font = UIFont(name: "Open Sans", size: 20)
        self.titleTextField.textColor = UIColor.whiteColor()
        self.titleTextField.placeholderColor = UIColor.whiteColor()
        self.titleTextField.placeholderActiveColor = UIColor.whiteColor()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if postInterest != nil || postInterest == ""{
            self.categoryButton.setTitle(postInterest, forState: .Normal)
        } else {
            self.categoryButton.setTitle("Pick a Category", forState: .Normal)
        }
        print(postInterest)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddLocationVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func cancelToAddLocation(segue:UIStoryboardSegue) {
        if segue.sourceViewController.isKindOfClass(SelectPostInterestVC){
            self.postInterest = (segue.sourceViewController as! SelectPostInterestVC).selectedCell
        }
    }
    
    @IBAction func addButtonTapped(sender: FlatButton) {
        //Its kinda messy, but it adds new posts
        if self.postInterest != "" || self.postInterest != nil && self.title != "" || self.title != nil {
            
            firebaseHelper.currentUser { user in
                
                let imageID = NSUUID().UUIDString
                let imageStorageRef = self.firebaseHelper.storageRef.child((FIRAuth.auth()?.currentUser?.uid)!).child(imageID)
            
                let localImage = UIImageJPEGRepresentation(self.imageView.image!, 0.9)
            
                let upload = imageStorageRef.putData(localImage!, metadata: nil) { metadata, error in
                    if (error != nil) {
                    
                    } else {
                    
                        // Metadata contains file metadata such as size, content-type, and download URL.
                        let newPost = Post(title: self.titleTextField.text!, description: self.descriptionTextView.text!, interest: self.categoryButton.titleLabel?.text!, longitude: self.locationManager.location!.coordinate.longitude.description, latitude: self.locationManager.location!.coordinate.latitude.description, user: user.UID!, imageID: "\(user.UID!)/\(imageID)")
                    
                        newPost.uploadPost()
                    
                    
                    }
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        } else {
            return
        }
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
}
