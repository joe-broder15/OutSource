//
//  InterestsVC.swift
//  OutSource
//
//  Created by JoeB on 7/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//

//import Cocoa
import UIKit
import Firebase

class InterestsVC: UITableViewController {

    let firebaseHelper = FirebaseHelper()
    var cells = [UITableViewCell]()
    var interests: [FIRDataSnapshot]! = []
    private var _refHandle: FIRDatabaseHandle!
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
        
    override func viewDidLoad() {
        self.configureDatabase()
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = true
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat", size: 24)!]
        
        self.doneButton.setTitleTextAttributes([NSFontAttributeName : UIFont(name: "Open Sans", size: 20)!], forState: .Normal)
        
      
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interests.count
    }
    
    //Creates each cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! TableViewCell
        
        let row = indexPath.row
        
        let interest = interests[row].value! as? String
 
        cell.textLabel!.text = interest
        cell.textLabel!.font = UIFont(name: "Montserrat", size: 24)
        cell.textLabel!.textColor = hexStringToUIColor("#40de96")
        //cell.
        cells.append(cell)

        return cell
        
    }
    
    //Gets all the interests of users
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("Interests").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            self.interests.append(snapshot)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.interests.count-1, inSection: 0)], withRowAnimation: .Automatic)
        })
    }
    
    @IBAction func doneBtnTapped(sender: UIBarButtonItem) {
        
        firebaseHelper.currentUser { user in
            
            var selectedCells = [String]()
            for cell in self.cells {
                if cell.selected == true {
                    selectedCells.append(cell.textLabel!.text!)
                }
            }
            self.firebaseHelper.usersRef.child(user.UID!).child("interests").setValue(selectedCells)
            self.performSegueWithIdentifier("interestsToTutorialSegue", sender: self)
            
        }
        
        
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
    
}




