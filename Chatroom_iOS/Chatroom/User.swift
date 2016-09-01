//
//  User.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 5/2/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import SwiftyJSON

class User: CustomStringConvertible {
    static var currentUser: User?
    
    let phoneNumber: String
    let displayName: String
    let id: String
    
    init(json: JSON) {
        phoneNumber = json["phoneNumber"].stringValue
        displayName = json["displayName"].stringValue
        id = json["id"].stringValue
    }
    
    var description: String { //repr?
        return "\(displayName) with number \(phoneNumber)"
    }
}