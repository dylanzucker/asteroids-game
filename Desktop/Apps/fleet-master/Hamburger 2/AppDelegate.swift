//
//  AppDelegate.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/4/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import TwitterKit
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let allData = DataBuilder()
    
    var myUser: Person?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        application.isStatusBarHidden = true

        // change tint
        self.window?.tintColor = Constants.Colors.themeColor
        
        // navigation bar - back button
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .highlighted)
        
        // set default user to: smithj
        let defaults = UserDefaults.standard
        let defaultValue = ["myUserName" : "jlin"]
        defaults.register(defaults: defaultValue)
        
        let username = defaults.string(forKey: "myUserName")
        if (username != "") {
            myUser = allData?.getPersonByUsername(username: username!)
        }
        
        // firebase
        FirebaseApp.configure() // Use Firebase library to configure APIs
        
        // firebase test
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("users").child("0001").setValue(["username": "test1"])
        
        // mixpanel
//        Mixpanel.sharedInstance(withToken: Constants.Mixpanel.token)
//        Mixpanel.sharedInstance()?.track("clicked profile")

        // twitter
        TWTRTwitter.sharedInstance().start(withConsumerKey: Constants.API.Twitter.consumerKey, consumerSecret: Constants.API.Twitter.consumerSecret)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

