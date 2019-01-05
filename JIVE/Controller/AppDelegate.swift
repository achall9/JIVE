//
//  AppDelegate.swift
//  JIVE
//
//  Created by RSS on 9/9/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard?
    var currentView: Int = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        if self.loadUser() {
            self.makingRoot("enterApp")
        }else {
            self.makingRoot("initial")
        }
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
    
    func loadUser() -> Bool {
        if UserDefaults.standard.object(forKey: "User") == nil {
            return false
        }
        User.sharedInstance.loadUserInfo(UserDefaults.standard.object(forKey: "User") as! NSDictionary)
        return true
    }
    
    func saveUser() {
        UserDefaults.standard.set(User.sharedInstance.getAllFields(), forKey: "User")
        UserDefaults.standard.synchronize()
    }
    
    func deleteUser() {
        User.sharedInstance.initialize()
        UserDefaults.standard.removeObject(forKey: "User")
    }
    
    func makingRoot(_ strRoot: String) {
        var nav : UINavigationController?
        if strRoot == "initial" {
            nav = storyboard!.instantiateViewController(withIdentifier :"initialNav") as? UINavigationController
            window?.rootViewController = nav
        }else if strRoot == "enterApp" {
            nav = storyboard!.instantiateViewController(withIdentifier :"enterAppNav") as? UINavigationController
            currentView = 0
            window?.rootViewController = nav
        }else if strRoot == "gotoProfile" {
            nav = storyboard!.instantiateViewController(withIdentifier :"enterAppNav") as? UINavigationController
            currentView = 2
            window?.rootViewController = nav
        }
        
        window?.makeKeyAndVisible()
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: { _ in })
        
    }


}

