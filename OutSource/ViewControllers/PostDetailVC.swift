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
import Firebase

class PostDetailVC: UIViewController {
    
    //THESE ARE FOR THE MENU
    // MenuView reference.
    private lazy var menuView: MenuView = MenuView()
    
    // Default spacing size
    let spacing: CGFloat = 16
    
    // Diameter for FabButtons.
    let diameter: CGFloat = 56
    
    // Height for FlatButtons.
    let height: CGFloat = 36
    
    var post = Post(title: "", description: "", interest: "", longitude: "", latitude: "", user: "", imageID: "", uid: "", timeLimit: 0)
    
    let firebaseHelper = FirebaseHelper()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var descriptionFeild: UITextView!
    
    override func viewDidLoad() {
        prepareMenuView()
        self.interestLabel.text = post.interest
        self.descriptionFeild.text = post.description
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat-Bold", size: 24)!]
        
        self.navigationController?.topViewController?.title = post.title
        
        
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
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

//MARK: THIS EXTENSION HANDLES THE MENU
extension PostDetailVC {
    
    /// Handle the menuView touch event.
    internal func handleMenu() {
        if menuView.menu.opened {
            menuView.menu.close()
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0))
        } else {
            menuView.menu.open() { (v: UIView) in
                (v as? MaterialButton)?.pulse()
            }
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0.125))
        }
    }
    
    /// Handle the menuView touch event.
    @objc(handleButton:)
    internal func handleButton(button: UIButton) {
        print("Hit Button \(button)")
    }
    
    /// Handles the location button.
    func flagAction() {
        
        let alert = UIAlertController(title: "Flag Content", message: "Would you like to flag this content as inappropriate?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Flag", style: .Default, handler: { action in
            self.firebaseHelper.ref.child("flags").child(self.post.uid!).setValue(true)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func blockAction(){
        
        let alert = UIAlertController(title: "Block User", message: "Would you like to no longer see posts from this user?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Block", style: .Default, handler: { action in
            self.firebaseHelper.usersRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("blocked").child(self.post.user!).setValue(self.post.user)
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }

    /// Prepares the MenuView example.
    private func prepareMenuView() {
        
        //MARK: first button
        var image: UIImage? = UIImage(named: "plusIcon")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn1: FabButton = FabButton()
        btn1.depth = .None
        btn1.pulseOpacity = 0
        btn1.borderColor = MaterialColor.white
        btn1.backgroundColor = self.hexStringToUIColor("#40DE96")
        btn1.borderWidth = 1
        btn1.setImage(image, forState: .Normal)
        btn1.setImage(image, forState: .Highlighted)
        btn1.addTarget(self, action: #selector(handleMenu), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn1)
        
        //MARK: second button (New Location)
        image = UIImage(named: "flagIcon")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn2: FabButton = FabButton()
        btn2.depth = .None
        btn2.pulseOpacity = 0
        btn2.borderColor = MaterialColor.white
        btn2.backgroundColor = self.hexStringToUIColor("#46F2AF")
        btn2.borderWidth = 1
        btn2.setImage(image, forState: .Normal)
        btn2.setImage(image, forState: .Highlighted)
        btn2.addTarget(self, action: #selector(flagAction), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn2)
        
        //MARK: third button
        image = UIImage(named: "banIcon")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn3: FabButton = FabButton()
        btn3.depth = .None
        btn3.pulseOpacity = 0
        btn3.borderColor = MaterialColor.white
        btn3.backgroundColor = self.hexStringToUIColor("#46F2AF")
        btn3.borderWidth = 1
        btn3.setImage(image, forState: .Normal)
        btn3.setImage(image, forState: .Highlighted)
        btn3.addTarget(self, action: #selector(blockAction), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn3)
        
        // Initialize the menu and setup the configuration options.
        menuView.menu.direction = .Up
        menuView.menu.baseSize = CGSizeMake(diameter, diameter)
        menuView.menu.views = [btn1, btn2, btn3]
        view.layout(menuView).width(diameter).height(diameter).bottom(16).right(5)
    }
}

//MARK: the color method
extension PostDetailVC{
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
}