//
//  AddTextVC.swift
//  OutSource
//
//  Created by JoeB on 8/30/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit
import Material
import Toast_Swift

class AddTextVC: UIViewController {
    
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var descriptionTextFeild: UITextView!
    
    var image = UIImage()
    
    
    override func viewDidLoad() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat", size: 24)!]
        
        self.titleTextField.font = UIFont(name: "Open Sans", size: 20)
        self.titleTextField.textColor = self.hexStringToUIColor("#40DE96")
        self.titleTextField.placeholderColor = self.hexStringToUIColor("#40DE96")
        self.titleTextField.placeholderActiveColor = self.hexStringToUIColor("#40DE96")
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func cancelToText(segue: UIStoryboardSegue) {}
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        if titleTextField.text == "" || titleTextField.text == nil {
            self.view.makeToast("Please set a title", duration: 1.0, position: .Center)
        } else if descriptionTextFeild.text == "" || descriptionTextFeild.text == nil {
            self.view.makeToast("Please set a description", duration: 1.0, position: .Center)
        } else {
            self.performSegueWithIdentifier("textToInterestsSegue", sender: self)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "textToInterestsSegue" {
            let vc = segue.destinationViewController as! SelectPostInterestVC
            vc.titleText = titleTextField.text!
            vc.descriptionText = descriptionTextFeild.text!
            vc.image = self.image
        }
    }
    
}

extension AddTextVC {
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddTextVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AddTextVC {
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}