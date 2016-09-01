//
//  MessageViewController.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 5/2/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    var group: Group!
    var messages: [Message] = []
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var entry: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //fetches messages. groupviewcontroller, pass groupid to messages
        API.sharedInstance.getMessages(group.id) { messages in //error, excecution bad instruction, won't exit from group message page
            self.messages = messages
            self.textView.text = messages.reduce("") { $0 + "\($1.sender): \($1.text)\n" }
        }
    
    }

    @IBAction func hitSend(sender: UIButton) {
        //sends messages?
        API.sharedInstance.sendMessage(group.id, message: entry.text!) { message in
            if self.entry.text != "" {
                self.textView.text.appendContentsOf("\(User.currentUser!.displayName): \(self.entry.text!)\n")
                self.entry.text = ""
            }
        }
    }
}
