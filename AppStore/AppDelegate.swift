//
//  AppDelegate.swift
//  AppStore
//
//  Created by Kim JungMoo on 25/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        SearchKeywordLoader.synchronize()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        SearchKeywordLoader.synchronize()
    }
}
