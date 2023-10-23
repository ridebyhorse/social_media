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
        view.backgroundColor = .cyan
        let infoItem = UIBarButtonItem(image: UIImage(systemName: "info"), style: .plain, target: self, action: #selector(didTapInfoItem))
        navigationItem.rightBarButtonItem = infoItem
    }
    
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapInfoItem() {
        print("Did Tap Info item")
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }

}
