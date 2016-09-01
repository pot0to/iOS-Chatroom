//
//  CreateGroupViewController.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 5/2/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UITableViewDataSource {
    
    var users: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func createGroup(sender: UIButton) {
        if name.text!.isEmpty {return} //Failure case
        
        guard let indexes = tableView.indexPathsForSelectedRows else {return}
        let ids = indexes.map {users[$0.row].id} //pulls user ids from selected users
        
        API.sharedInstance.createGroup(name.text!, members: ids) { (json) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        API.sharedInstance.allUsers { [weak self] users in
            self?.users = users
            self?.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.UserCell.rawValue)!
        cell.textLabel?.text = users[indexPath.row].displayName
        return cell
    }
    

}
