//
//  AppDelegate.swift
//  eFFUNOV5
//
//  Created by admin on 21/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
//        NotificationCenter.default.addObserver(
//            self, selector: #selector(AppDelegate.rotated),
//            name: UIDevice.orientationDidChangeNotification, object: nil)
//
        return true
    }
    
//    @objc func rotated() {
//        if UIApplication.shared.statusBarOrientation.isLandscape {
//            print("landscape Appdelegate")
//        } else {
//            print("portrait AppDelegate")
//        }
//
//    }

}

