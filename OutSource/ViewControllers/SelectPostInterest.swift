//
//  SelectPostInterest.swift
//  OutSource
//
//  Created by JoeB on 8/7/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SelectPostInterestVC: UITableViewController {
    
    let firebaseHelper = FirebaseHelper()
    var cells = [UITableViewCell]()
    var selectedCell = String()
    var interests: [FIRDataSnapshot]! = []
    private var _refHandle: FIRDatabaseHandle!
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        self.configureDatabase()
        super.viewDidLoad()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat", size: 24)!]
        
        self.doneButton.setTitleTextAttributes([NSFontAttributeName : UIFont(name: "Open Sans", size: 20)!], forState: .Normal)
        
        
    }
    
    //adds check to selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        self.selectedCell = (tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!
        print(self.selectedCell)
    }
    
    //removes check at selection
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
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
        _refHandle = self.ref.child("Interests").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            self.interests.append(snapshot)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.interests.count-1, inSection: 0)], withRowAnimation: .Automatic)
        })
    }
    
    @IBAction func doneBtnTapped(sender: UIBarButtonItem) {
        
        for cell in self.cells {
            if cell.selected == true {
                self.selectedCell = cell.textLabel!.text!
            }
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