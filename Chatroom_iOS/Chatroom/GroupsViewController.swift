//
//  GroupsViewController.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 5/2/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDataSource {
    
    var groups: [Group] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        API.sharedInstance.allGroups { groups in
            self.groups = groups
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.GroupCell.rawValue)!
        cell.textLabel?.text = groups[indexPath.row].name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let messagesVC = segue.destinationViewController as? MessageViewController else { return } //sends info to MessageViewController
        let index = tableView.indexPathForSelectedRow! //specify which group from array. row, etc
        messagesVC.group = groups[index.row] //pulls group fom selected users?
    }

}
