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
        let homeViewController = HomeViewController()
        let homePresenter = HomePresenter()
        let homeController = HomeController()
        let loadComponentsUseCase = LoadComponentsUseCase()
        
        homeViewController.controller = homeController
        homePresenter.view = homeViewController
        homeController.input = loadComponentsUseCase
        loadComponentsUseCase.output = homePresenter
        
        return homeViewController
    }()
}

