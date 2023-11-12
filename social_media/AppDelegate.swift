//
//  AppDelegate.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let feedViewController = FeedViewController()
        let feedNavigationVC = UINavigationController(rootViewController: feedViewController)
        feedNavigationVC.title = "Feed"
        feedNavigationVC.tabBarItem.title = "Feed"
        feedNavigationVC.tabBarItem.image = UIImage(systemName: "line.horizontal.3.decrease")
        
        let loginViewController = LogInViewController()
        let loginInspectorFactory = MyLoginFactory()
        loginViewController.loginDelegate = loginInspectorFactory.makeLoginInspector()
        let profileNavigationVC = UINavigationController(rootViewController: loginViewController)
        profileNavigationVC.title = "Profile"
        profileNavigationVC.tabBarItem.title = "Profile"
        profileNavigationVC.tabBarItem.image = UIImage(systemName: "person.fill")
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [feedNavigationVC, profileNavigationVC]
        tabbarController.tabBar.backgroundColor = .white
        
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
        
    }


}

