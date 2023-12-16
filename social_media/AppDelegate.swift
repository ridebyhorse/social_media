//
//  AppDelegate.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        coordinator = MainCoordinator()
        
        window?.rootViewController = coordinator?.tabbarController
        window?.makeKeyAndVisible()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        coordinator?.start()
        
        return true
        
    }


}

