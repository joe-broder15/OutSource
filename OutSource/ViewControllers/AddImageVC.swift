//
//  AddImageVC.swift
//  OutSource
//
//  Created by JoeB on 8/30/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit
import Material

class AddImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var retakeButton: FlatButton!
    @IBOutlet weak var nextButton: FlatButton!
    
    var postImage = UIImage()
    
    override func viewDidLoad() {
        
        self.retakeButton.layer.zPosition = CGFloat.max
        self.nextButton.layer.zPosition = CGFloat.max
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat", size: 24)!]
        
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
        self.postImage = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imageToTextSegue" {
            let destination = segue.destinationViewController as! AddTextVC
            destination.image = self.postImage
        }
    }
    
    @IBAction func cancelToImage(segue: UIStoryboardSegue) {}
    
    @IBAction func imageButtonTapped(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("imageToTextSegue", sender: self)
        
    }
    
}