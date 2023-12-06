//
//  FeedCoordinator.swift
//  social_media
//
//  Created by Мария Нестерова on 01.12.2023.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    
    struct Input {
        let title: String
        let tabBarImage: UIImage?
    }
    
    var childCoordinators = [Coordinator]()
    
    var navigation: UINavigationController
    
    unowned let parentCoordinator: MainCoordinator
    
    private var input: Input?
    
    var onComplete: (() -> Void)?
    
    init(input: Input, parentCoordinator: MainCoordinator, navigation: UINavigationController) {
        self.input = input
        self.parentCoordinator = parentCoordinator
        self.navigation = navigation
        
    }
    
    func start() {
        startFeedFlow()
        navigation.title = input?.title
        navigation.tabBarItem.title = input?.title
        navigation.tabBarItem.image = input?.tabBarImage
        
        
    }
    
    private func startFeedFlow() {
        let feedViewController = FeedViewController(model: FeedModel())
        feedViewController.coordinator = self
        feedViewController.showPost = presentPostModule
        
        navigation.pushViewController(feedViewController, animated: true)
    }
    
    private func presentPostModule() {
        let postViewController = PostViewController(title: "Hello, everyone!")
        postViewController.coordinator = self
        postViewController.showInfo = presentInfoModule
        
        navigation.pushViewController(postViewController, animated: true)
    }
    
    private func presentInfoModule() {
        let infoViewController = InfoViewController()
        infoViewController.coordinator = self
        
        navigation.present(infoViewController, animated: true)
    }
}
