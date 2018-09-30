//
//  AppDelegate.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/5.
//  Copyright © 2018年 提运佳. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        GlobalAppearance.setupUIAppearance()
        self.window?.rootViewController = RootTabBarController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillTerminate(_ application: UIApplication) {}

}

extension AppDelegate {
    
}
