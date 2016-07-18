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
    var interests: [FIRDataSnapshot]! = []
    private var _refHandle: FIRDatabaseHandle!
    var ref: FIRDatabaseReference!
    
    
        
    override func viewDidLoad() {
        self.configureDatabase()
        super.viewDidLoad()
        
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("Interests").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            self.interests.append(snapshot)
            //print(self.interests)
            //print(self.interests[0].value!)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.interests.count-1, inSection: 0)], withRowAnimation: .Automatic)
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! TableViewCell
        
        //1
        let row = indexPath.row
        
        //2
        let interest = interests[row].value
        
        //3
        cell.textLabel!.text = interest! as? String

        //4
        //cell.noteTimeModifiedLabel.text = note.modificationTime.convertToString()

        return cell
        
    }
    
    
}



