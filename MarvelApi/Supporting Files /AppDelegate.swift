//
//  AppDelegate.swift
//  MarvelApi
//
//  Created by lapshop on 11/7/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIUtitly.getHomeNavigationViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }

 


}

