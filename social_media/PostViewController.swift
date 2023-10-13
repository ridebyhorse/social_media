//
//  PostViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if title == nil {
            title = "Some post"
        }
        view.backgroundColor = .cyan
        
        
        let infoItem = UIBarButtonItem(image: UIImage(systemName: "info"), style: .plain, target: self, action: #selector(didTapInfoItem))
        navigationItem.rightBarButtonItem = infoItem
    }
    
    @objc func didTapInfoItem() {
        print("Info item tapped")
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
    

}
