//
//  ProfileCoordiinator.swift
//  social_media
//
//  Created by Мария Нестерова on 01.12.2023.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
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
        startLoginFlow()
        navigation.title = input?.title
        navigation.tabBarItem.title = input?.title
        navigation.tabBarItem.image = input?.tabBarImage
        
    }
    
    private func startLoginFlow() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        loginViewController.didLoggedIn = self.startProfileFlow(user:)
        
        let loginInspectorFactory = MyLoginFactory()
        loginViewController.loginDelegate = loginInspectorFactory.makeLoginInspector()
        
        navigation.pushViewController(loginViewController, animated: true)
    }
    
    func startProfileFlow(user: User) {
        let profileViewController = ProfileViewController(viewModel: ProfileViewModel(model: ProfileModel(user: user)))
        profileViewController.coordinator = self
        
        navigation.pushViewController(profileViewController, animated: true)
    }
}
