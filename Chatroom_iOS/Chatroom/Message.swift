//
//  Message.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 5/2/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import SwiftyJSON

class Message {
    let sender: String // Display name of user sending message
    let text: String // Text of message
    let senderId: String
    let sentOn: String // Date sent
    
    init(json: JSON) {
        sender = json["sender"].stringValue
        text = json["text"].stringValue
        senderId = json["senderId"].stringValue
        sentOn = json["sentOn"].stringValue
    }
}
