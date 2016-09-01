//
//  LoginViewController.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 4/17/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var displayName: UITextField!
    
    @IBAction func register() {
        if phone.text!.isEmpty || password.text!.isEmpty || displayName.text!.isEmpty { return } // Failure case
        
        API.sharedInstance.register(phone.text!, password: password.text!, displayName: displayName.text!) { user in
            User.currentUser = user
            self.performSegueWithIdentifier(Segues.LoginToGroupList.rawValue, sender: nil)
        }
        
    }
    
    @IBAction func login() {
        if phone.text!.isEmpty || password.text!.isEmpty { return } // Failure case
        
        API.sharedInstance.login(phone.text!, password: password.text!) { user in
            User.currentUser = user
            self.performSegueWithIdentifier(Segues.LoginToGroupList.rawValue, sender: nil)
        }
    }
    
}
