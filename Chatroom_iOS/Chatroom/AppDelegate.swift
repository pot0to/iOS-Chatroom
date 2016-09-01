//
//  AppDelegate.swift
//  Chatroom
//
//  Created by Lucas Derraugh on 4/17/16.
//  Copyright © 2016 Lucas Derraugh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        API.sharedInstance.register("7577630609", password: "myPassword", displayName: "celine")
//        API.sharedInstance.login("6077933517", password: "myPassword")
//        API.sharedInstance.allUsers()
//        API.sharedInstance.createGroup("AwesomeGroup", members: ["571437d335444e75537a8c88", "57144b73441f5e4c55fa9440"])
//        API.sharedInstance.allGroups()
//        API.sharedInstance.getMessages("57145eb2d1aafbd756df3cf1")
        // Override point for customization after application launch.
        return true
    }
    
//    {
//    "groups" : [
//    {
//    "name" : "AwesomeGroup",
//    "id" : "57145eb2d1aafbd756df3cf1",
//    "members" : [
//    {
//    "id" : "571437d335444e75537a8c88",
//    "phoneNumber" : "6077933517",
//    "displayName" : "lucasderraugh"
//    },
//    {
//    "id" : "57144b73441f5e4c55fa9440",
//    "phoneNumber" : "7577630609",
//    "displayName" : "celine"
//    }
//    ]
//    }
//    ],
//    "status" : "success"
//    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

