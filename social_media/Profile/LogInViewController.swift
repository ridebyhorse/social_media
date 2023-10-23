//
//  LogInViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 17.10.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "AppIcon")
        
        return logo
    }()
    
    private let loginFormBackgroundView: UIView = {
        let loginFormBackgroundView = UIView()
        loginFormBackgroundView.backgroundColor = .systemGray2
        loginFormBackgroundView.layer.cornerRadius = 10
        loginFormBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        loginFormBackgroundView.layer.borderWidth = 0.5
        
        return loginFormBackgroundView
    }()
    
    private let lineSeparatorLoginForm: UIView = {
        let lineSeparatorLoginForm = UIView()
        lineSeparatorLoginForm.backgroundColor = .lightGray
        
        return lineSeparatorLoginForm
    }()
    
    private let loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.placeholder = "Email or phone"
        loginTextField.textColor = .black
        loginTextField.font = .systemFont(ofSize: 16, weight: .regular)
        loginTextField.tintColor = UIColor(named: "AccentColor")
        
        return loginTextField
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .black
        passwordTextField.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField.tintColor = UIColor(named: "AccentColor")
        passwordTextField.isSecureTextEntry = true
        
        return passwordTextField
    }()
    
    private let logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.setTitle("Log In", for: .normal)
        logInButton.backgroundColor = UIColor(named: "AccentColor")
        logInButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        logInButton.titleLabel?.textColor = .white
        logInButton.layer.cornerRadius = 10
        switch logInButton.state {
        case .normal:
            logInButton.alpha = 1
        default:
            logInButton.alpha = 0.8
        }
        logInButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
        
        return logInButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // подписаться на уведомления
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }

    

    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.addSubview(logo)
        scrollView.addSubview(loginFormBackgroundView)
        scrollView.addSubview(lineSeparatorLoginForm)
        scrollView.addSubview(loginTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(logInButton)
        
        
        
        for view in self.view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        for view in scrollView.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            logo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            
            loginFormBackgroundView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 100),
            loginFormBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            loginFormBackgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginFormBackgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            
            lineSeparatorLoginForm.heightAnchor.constraint(equalToConstant: 0.4),
            lineSeparatorLoginForm.widthAnchor.constraint(equalTo: loginFormBackgroundView.widthAnchor),
            lineSeparatorLoginForm.centerYAnchor.constraint(equalTo: loginFormBackgroundView.centerYAnchor),
            lineSeparatorLoginForm.centerXAnchor.constraint(equalTo: loginFormBackgroundView.centerXAnchor),
            
            loginTextField.leadingAnchor.constraint(equalTo: loginFormBackgroundView.leadingAnchor, constant: 8),
            loginTextField.trailingAnchor.constraint(equalTo: loginFormBackgroundView.trailingAnchor, constant: -16),
            loginTextField.topAnchor.constraint(equalTo: loginFormBackgroundView.topAnchor, constant: 16),
            
            passwordTextField.leadingAnchor.constraint(equalTo: loginFormBackgroundView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: loginFormBackgroundView.trailingAnchor, constant: -16),
            passwordTextField.topAnchor.constraint(equalTo: lineSeparatorLoginForm.topAnchor, constant: 16),
            
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: loginFormBackgroundView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: loginFormBackgroundView.trailingAnchor),
            logInButton.topAnchor.constraint(equalTo: loginFormBackgroundView.bottomAnchor, constant: 16),
            logInButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100)
        ])
    }
    
    @objc func didTapLogInButton() {
        print("Did tap Log In Button")
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    // Изменение отступов при появлении клавиатуры
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        scrollView.contentInset.bottom = kbdSize.height
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0) }
    }
    
    @objc private func kbdHide(notification: NSNotification) { 
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

}

