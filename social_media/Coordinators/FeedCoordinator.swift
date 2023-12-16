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
    
    private var audioNoteViewControllerDelegate: AudioNoteViewControllerDelegate?
    
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
        feedViewController.showPost = presentVideoPostModule
        feedViewController.showAudio = presentAudioModule
        
        navigation.pushViewController(feedViewController, animated: true)
    }
    
    private func presentVideoPostModule() {
        let postViewController = PostViewController(title: "Recent videoposts")
        postViewController.coordinator = self
        postViewController.showVideoPlayer = { url in
            self.presentVideoPlayerModule(url: url)
        }
        
        navigation.pushViewController(postViewController, animated: true)
    }
    
    private func presentAudioModule() {
        let audioViewController = AudioViewController(title: "Audionotes")
        audioViewController.makeNote = presentAudioNoteModule
        audioNoteViewControllerDelegate = audioViewController
        navigation.pushViewController(audioViewController, animated: true)
    }
    
    private func presentAudioNoteModule() {
        let audioNoteViewController = AudioNoteViewController()
        audioNoteViewController.coordinator = self
        audioNoteViewController.onComplete = {
            self.navigation.dismiss(animated: true)
        }
        guard let audioNoteViewControllerDelegate else { return }
        audioNoteViewController.delegate = audioNoteViewControllerDelegate
        
        navigation.present(audioNoteViewController, animated: true)
    }
    
    private func presentVideoPlayerModule(url: URL) {
        let videoPlayerViewController = PlayerViewController(url: url)
        
        navigation.pushViewController(videoPlayerViewController, animated: true)
        
    }
}
