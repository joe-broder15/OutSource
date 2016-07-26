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
    
    
    
        
    override func viewDidLoad() {
        self.configureDatabase()
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = true
        
    }
    
    //This lets you select multiple cells
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    //This also does multiple selection
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
        let currentUser = self.firebaseHelper.currentUser
        var selectedCells = [String]()
        for cell in cells {
            if cell.selected == true {
                selectedCells.append(cell.textLabel!.text!)
            }
        }
//        firebaseHelper.usersRef.child(currentUser().UID!).child("interests").setValue(selectedCells)
        self.performSegueWithIdentifier("interestsToMapSegue", sender: self)
    }
    
    
}



