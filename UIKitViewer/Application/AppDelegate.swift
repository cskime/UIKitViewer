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
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.tintColor = .black
        window?.rootViewController = navigationController
        
        return true
    }
    
    private lazy var homeViewController: HomeViewController = {
        let presenter = HomePresenter()
        let loadComponentsUseCase = LoadComponentsUseCase(output: presenter)
        let homeController = HomeController(input: loadComponentsUseCase)
        return HomeViewController(controller: homeController)
    }()
}

