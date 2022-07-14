//
//  AppDelegate.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 29.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController.init()
        self.appCoordinator = AppCoordinator(navigationController: navigationController)
        window?.rootViewController = navigationController
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }





}

