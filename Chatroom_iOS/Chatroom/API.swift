//
//  API.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 4/17/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private enum Router: URLStringConvertible {
    //interface with server. many routes
    case AllUsers
    case AllGroups
    case CreateGroup
    case Group
    case Login
    case Register
    case SendMessage
    
    var URLString: String {
        let endValue: String = {
            switch self {
            case .AllUsers:
                return "users/all"
            case .AllGroups:
                return "groups/all"
            case .CreateGroup:
                return "groups/create"
            case .Group:
                return "groups/get"
            case .Login:
                return "users/login"
            case .Register:
                return "users/register"
            case .SendMessage:
                return "messages/send"
            }
        }()
        return "http://localhost:3000/\(endValue)" //maps to local machine. you run localhost, sever runs port 3000
    }
}

class API {
    //when you start sending data
    static let sharedInstance = API()
    let sessionCodeKey = "ChatroomSessionCodeKey"
    
    private var sessionCode: String {
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: sessionCodeKey)
        }
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey(sessionCodeKey) ?? ""
        }
    }
    
    let map: [String: AnyObject] -> JSON = {
        let json = JSON($0)
        print(json)
        return json
    }
    
    func allUsers(completion: [User] -> Void) { //finds all users available in platform. gives them in array. can be void
        let map: [String: AnyObject] -> [User] = { //converts whatever you get back into a string. can be an array of users
            JSON($0)["users"].arrayValue.map { User(json: $0) } //user is a json object
        }
        get(.AllUsers, params: ["session_code": sessionCode], map: map, completion: completion) //the route and the parameters necessary. "get all users" route. map makes a dictionary of what you get back from the request
    }
    
    func allGroups(completion: [Group] -> Void) {
        let map: [String: AnyObject] -> [Group] = {
            JSON($0)["groups"].arrayValue.map { Group(json: $0) }
        }
        get(.AllGroups, params: ["session_code": sessionCode], map: map, completion: completion)
    }
    
    func createGroup(groupName: String, members: [String], completion: JSON -> Void) {
        post(.CreateGroup, params: ["session_code": sessionCode, "name": groupName, "members": members], map: map, completion: completion)
    }
    
    func getMessages(groupId: String, completion: [Message] -> Void) {
        let map: [String: AnyObject] -> [Message] = {
            JSON($0)["messages"].arrayValue.map { Message(json: $0) }
        }
        get(.Group, params: ["session_code": sessionCode, "groupId": groupId], map: map, completion: completion)
    }
    
    func login(phone: String, password: String, completion: User -> Void) {
        let loginMap: [String: AnyObject] -> User? = {
            guard let user = $0["user"] as? [String: String] else { return nil }
            self.sessionCode = $0["session_code"] as? String ?? ""
            return User(json: JSON(user))
        }
        post(.Login, params: ["phoneNumber": phone, "password": password], map: loginMap, completion: completion)
    }
    
    func register(phone: String, password: String, displayName: String, completion: User -> Void) {
        let loginMap: [String: AnyObject] -> User? = {
            guard let user = $0["user"] as? [String: String] else { return nil }
            self.sessionCode = $0["session_code"] as? String ?? ""
            return User(json: JSON(user))
        }
        post(.Register, params: ["phoneNumber": phone, "password": password, "displayName": displayName], map: loginMap, completion: completion)
    }
    
    func sendMessage(group: String, message: String, completion: JSON -> Void) {
//        let map: [String: AnyObject] -> Message? = {
//            guard let message = $0["message"] as? [String: String] else { return nil }
//            self.sessionCode = $0["session_code"] as? String ?? ""
//            return Message(json: JSON(message))
//        }
        post(.SendMessage, params: ["session_code": sessionCode, "group": group, "text": message], map: map, completion: completion)
    }
    
    private func post<O, T>(router: Router, params: [String: AnyObject], map: O -> T?, completion: (T -> Void)? = nil) {
        makeNetworkRequest(.POST, router: router, params: params, map: map, completion: completion)
    }
    
    private func get<O, T>(router: Router, params: [String: AnyObject], map: O -> T?, completion: (T -> Void)? = nil) {
        makeNetworkRequest(.GET, router: router, params: params, map: map, completion: completion)
    }
    
    private func makeNetworkRequest<O, T>(method: Alamofire.Method, router: Router, params: [String: AnyObject], map: O -> T?, completion: (T -> Void)?) {
        let encoding: ParameterEncoding = method == .GET ? .URL : .JSON
        Alamofire
            .request(method, router, parameters: params, encoding: encoding)
            .responseJSON { response in
                if let json = response.result.value as? O {
                    if let obj = map(json) {
                        completion?(obj)
                    } else {
                        print("Error on mapping \(json) from \(O.self) to \(T.self)")
                    }
                } else if let error = response.result.error {
                    print(error)
                }
        }
    }
    
    
}