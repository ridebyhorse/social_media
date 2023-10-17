//
//  FeedViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class FeedViewController: UIViewController {
   
    private let post = Post(title: "Hello, everyone!")
    
    private let showPostButton: UIButton = {
        let showPostButton = UIButton()
        showPostButton.backgroundColor = .systemRed
        showPostButton.setTitleColor(.white, for: .normal)
        showPostButton.translatesAutoresizingMaskIntoConstraints = false
        showPostButton.addTarget(self, action: #selector(didTapShowPostButton), for: .touchUpInside)
        showPostButton.setTitle("Show post", for: .normal)
        showPostButton.layer.cornerRadius = 8
        showPostButton.translatesAutoresizingMaskIntoConstraints = false
        
        return showPostButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(showPostButton)
        
        NSLayoutConstraint.activate([
            showPostButton.widthAnchor.constraint(equalToConstant: 120),
            showPostButton.heightAnchor.constraint(equalToConstant: 40),
            showPostButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
    }
    
    @objc func didTapShowPostButton() {
        print("Did tap Show Post button")
        let postViewController = PostViewController(title: post.title)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
