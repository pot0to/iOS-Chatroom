//
//  Group.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 5/2/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import Foundation
import SwiftyJSON

class Group {
    let name: String
    let id: String
    
    let messages: [Message]
    
    init(json: JSON) {
        name = json["name"].stringValue
        id = json["id"].stringValue
        
        messages = json["messages"].arrayValue.map { Message(json: $0) }
    }
}
