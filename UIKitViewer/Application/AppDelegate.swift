//
//  AppDelegate.swift
//  UIKitViewer
//
//  Created by cskim on 2020/01/31.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    sleep(1)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let vc = UINavigationController(rootViewController: MainViewController())
    vc.navigationBar.tintColor = .black
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
    
    return true
  }
}

