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

class AddLocationVC: UIViewController {
    
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var interestTextField: TextField!
    @IBOutlet weak var descriptionTextView: TextView!
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddLocationVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func addButtonTapped(sender: FabButton) {
        let newPost = Post(title: self.titleTextField.text!, description: self.descriptionTextView.text!, interest: self.interestTextField.text!)
        newPost.uploadPost()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
