//
//  PlayerViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 15.12.2023.
//

import Foundation
import AVFoundation
import AVKit

class PlayerViewController: AVPlayerViewController {
    
    private let url: URL
    
    weak var coordinator: Coordinator?
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        navigationController?.navigationBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(animated)
    }
    
    private func setup() {
        player = AVPlayer(url: url)
        player?.play()
    }
    
}
