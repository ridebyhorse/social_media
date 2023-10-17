//
//  ProfileViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        
        return profileHeader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray5
        view.addSubview(profileHeader)
        
        NSLayoutConstraint.activate([
            profileHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeader.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            profileHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
}
