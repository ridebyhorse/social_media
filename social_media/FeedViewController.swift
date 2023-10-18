//
//  FeedViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class FeedViewController: UIViewController {
   
    private let post = Post(title: "Hello, everyone!")
    
    private let feedButtonsView: UIStackView = {
        let feedButtonsView = UIStackView()
        feedButtonsView.translatesAutoresizingMaskIntoConstraints = false
        feedButtonsView.axis = .vertical
        feedButtonsView.distribution = .equalSpacing
        feedButtonsView.spacing = 16
        feedButtonsView.alignment = .center
        
        return feedButtonsView
    }()
    
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
    
    private let doNothingButton: UIButton = {
        let doNothingButton = UIButton()
        doNothingButton.backgroundColor = .systemYellow
        doNothingButton.setTitleColor(.white, for: .normal)
        doNothingButton.translatesAutoresizingMaskIntoConstraints = false
        doNothingButton.addTarget(self, action: #selector(didTapDoNothingButton), for: .touchUpInside)
        doNothingButton.setTitle("Do Nothing", for: .normal)
        doNothingButton.layer.cornerRadius = 8
        doNothingButton.translatesAutoresizingMaskIntoConstraints = false
        
        return doNothingButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(feedButtonsView)
        feedButtonsView.addArrangedSubview(showPostButton)
        feedButtonsView.addArrangedSubview(doNothingButton)

        
        NSLayoutConstraint.activate([
            feedButtonsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            feedButtonsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showPostButton.heightAnchor.constraint(equalToConstant: 40),
            showPostButton.widthAnchor.constraint(equalToConstant: 120),
            doNothingButton.heightAnchor.constraint(equalTo: showPostButton.heightAnchor),
            doNothingButton.widthAnchor.constraint(equalTo: showPostButton.widthAnchor)
        ])
        
    }
    
    @objc func didTapShowPostButton() {
        print("Did tap Show Post button")
        let postViewController = PostViewController(title: post.title)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func didTapDoNothingButton() {
        print("Did tap Do Nothing button")
    }
    
}
