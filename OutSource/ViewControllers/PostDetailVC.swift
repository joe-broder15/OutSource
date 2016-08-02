//
//  PostDetailVC.swift
//  OutSource
//
//  Created by JoeB on 8/1/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit
import Material

class PostDetailVC: UIViewController {
    var post = Post(title: nil, description: nil, interest: nil, longitude: nil, latitude: nil, user: nil, imageID: nil)
    
    let firebaseHelper = FirebaseHelper()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var descriptionFeild: UITextView!
    
    override func viewDidLoad() {
        self.titleLabel.text = post.title
        self.interestLabel.text = post.interest
        self.descriptionFeild.text = post.description
        
        // Download post image
        self.firebaseHelper.storageRef.child(post.imageID!).dataWithMaxSize(1 * 6000 * 6000) { (data, error) -> Void in
            if (error != nil) {
                print(error?.description)
            } else {
                
                print("image downloaded")
                
                self.imageView.image = UIImage(data: data!)!
            }
        }
    }
    
    @IBAction func cancelButtonTapped(sender: RaisedButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}