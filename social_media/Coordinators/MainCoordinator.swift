//
//  MainCoordinator.swift
//  social_media
//
//  Created by Мария Нестерова on 01.12.2023.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var tabbarController: UITabBarController
    
    var navigation: UINavigationController
    
    var profileNavigation: UINavigationController
    
    var onComplete: (() -> Void)?
    
    init() {
        
        self.tabbarController = UITabBarController()
        self.navigation = UINavigationController()
        self.profileNavigation = UINavigationController()
        
    }
    
    func start() {
        tabbarController.tabBar.backgroundColor = .white
        tabbarController.viewControllers = [navigation, profileNavigation]
        startFeedFlow()
        startProfileFlow()
    }
    
    private func startFeedFlow() {
        let feedCoordinator = FeedCoordinator(input: FeedCoordinator.Input(title: "Feed", tabBarImage: UIImage(systemName: "line.horizontal.3.decrease")), parentCoordinator: self, navigation: navigation)
        childCoordinators.append(feedCoordinator)
        feedCoordinator.onComplete = {
            print("Quit from Feed Coordinator")
        }
        
        feedCoordinator.start()
        
    }
    
    private func startProfileFlow() {
        let profileCoordinator = ProfileCoordinator(input: ProfileCoordinator.Input(title: "Profile", tabBarImage: UIImage(systemName: "person.fill")), parentCoordinator: self, navigation: profileNavigation)
        childCoordinators.append(profileCoordinator)
        profileCoordinator.onComplete = {
            print("Quit from Profile Coordinator")
        }
        
        profileCoordinator.start()
        
    }
}

