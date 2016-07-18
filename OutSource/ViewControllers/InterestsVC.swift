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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // firebaseHelper.getInterests()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! TableViewCell
        
//        //1
//        let row = indexPath.row
//        
//        //2
//        let note = notes[row]
//        
//        //3
//        cell.noteTitleLabel.text = note.title
//        
//        //4
//        cell.noteTimeModifiedLabel.text = note.modificationTime.convertToString()
        
        return cell
    }
    
    
}



