//
//  InfoViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let showAlertButton: UIButton = {
        let showAlertButton = UIButton()
        showAlertButton.backgroundColor = .white
        showAlertButton.setTitleColor(.black, for: .normal)
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false
        
        showAlertButton.setTitle("Show alert", for: .normal)
        showAlertButton.layer.cornerRadius = 8
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false
        
        return showAlertButton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        showAlertButton.addTarget(self, action: #selector(didTapShowAlertButton), for: .touchUpInside)
        
        view.addSubview(showAlertButton)
        
        NSLayoutConstraint.activate([
            showAlertButton.widthAnchor.constraint(equalToConstant: 120),
            showAlertButton.heightAnchor.constraint(equalToConstant: 40),
            showAlertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    @objc func didTapShowAlertButton() {
        print("Did tap Show Alert button")
        let alertViewController = UIAlertController(title: "Hello there", message: "Welcome to my app", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Hi!", style: .default){_ in
            print("Did close Alert controller by tapping 'Hi!' action")
        })
        present(alertViewController, animated: true)
        
    }
}
