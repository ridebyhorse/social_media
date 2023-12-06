//
//  InfoViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private lazy var showAlertButton: CustomButton = {
        let showAlertButton = CustomButton(title: "Show alert", color: .white, titleColor: .black)
        showAlertButton.onTap = {
            self.showAlert()
        }
        
        return showAlertButton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setup()
        
    }
    
    private func setup() {
        view.addSubview(showAlertButton)
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showAlertButton.widthAnchor.constraint(equalToConstant: 120),
            showAlertButton.heightAnchor.constraint(equalToConstant: 40),
            showAlertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func showAlert() {
        print("Did tap Show Alert button")
        let alertViewController = UIAlertController(title: "Hello there", message: "Welcome to my app", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Hi!", style: .default){_ in
            print("Did close Alert controller by tapping 'Hi!' action")
        })
        present(alertViewController, animated: true)
        
    }
}
