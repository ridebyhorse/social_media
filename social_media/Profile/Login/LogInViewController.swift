//
//  LogInViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 17.10.2023.
//

import UIKit

protocol LoginViewControllerDelegate {
    func checkLogin(login: String) -> Bool
    func checkPassword(password: String) -> Bool
    func generateNewPassword(of: Int)
}

enum LogInError: Error {
    case incorrectInput
    case noDataForUser
}

class LogInViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    var didLoggedIn: ((User) -> Void)?
    
    var loginDelegate: LoginViewControllerDelegate?
    
    private var userService: UserService?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "AppIcon")
        
        return logo
    }()
    
    private lazy var loginFormBackgroundView: UIView = {
        let loginFormBackgroundView = UIView()
        loginFormBackgroundView.backgroundColor = .systemGray2
        loginFormBackgroundView.layer.cornerRadius = 10
        loginFormBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        loginFormBackgroundView.layer.borderWidth = 0.5
        
        return loginFormBackgroundView
    }()
    
    private lazy var lineSeparatorLoginForm: UIView = {
        let lineSeparatorLoginForm = UIView()
        lineSeparatorLoginForm.backgroundColor = .lightGray
        
        return lineSeparatorLoginForm
    }()
    
    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.placeholder = "Email or phone"
        loginTextField.textColor = .black
        loginTextField.font = .systemFont(ofSize: 16, weight: .regular)
        loginTextField.tintColor = UIColor(named: "AccentColor")
        
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .black
        passwordTextField.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField.tintColor = UIColor(named: "AccentColor")
        passwordTextField.isSecureTextEntry = true
        
        return passwordTextField
    }()
    
    private lazy var logInButton: UIButton = {
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
    
    private lazy var guessPasswordButton: UIButton = {
        let guessPasswordButton = UIButton()
        guessPasswordButton.setTitle("Generate password and guess", for: .normal)
        guessPasswordButton.backgroundColor = .purple
        guessPasswordButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        guessPasswordButton.titleLabel?.textColor = .white
        guessPasswordButton.layer.cornerRadius = 10
        guessPasswordButton.addTarget(self, action: #selector(didTapPasswordButton), for: .touchUpInside)
        
        return guessPasswordButton
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor(named: "AccentColor")
        
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        view.backgroundColor = .black
        userService = TestUserService()
        #else
        view.backgroundColor = .white
        userService = CurrentUserService()
        #endif
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
        scrollView.addSubview(guessPasswordButton)
        scrollView.addSubview(activityIndicator)
        
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
            logInButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100),
            guessPasswordButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 32),
            guessPasswordButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor, constant: 16),
            guessPasswordButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor, constant: -16),
            guessPasswordButton.heightAnchor.constraint(equalTo: logInButton.heightAnchor),
            activityIndicator.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, multiplier: 0.8),
            activityIndicator.widthAnchor.constraint(equalTo: activityIndicator.heightAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -8)
        ])
        
        
    }
    
    
    @objc private func didTapLogInButton() {
        print("Did tap Log In Button")
        let loginInput: String = loginTextField.text != nil ? loginTextField.text! : ""
        let passwordInput: String = passwordTextField.text != nil ? passwordTextField.text! : ""
        print("User trying to log in with \(loginInput == "" ? "no" : loginInput) login")
        let correct: Bool = {
            if let answerLogin = loginDelegate?.checkLogin(login: loginInput) {
                if let answerPassword = loginDelegate?.checkPassword(password: passwordInput) {
                    return answerLogin && answerPassword
                } else {
                    return false
                }
            } else {
                return false
            }
        }()
        
        var user: User?
        userService?.checkUser(login: loginInput) { result in
            switch result {
            case .success(let userInput):
                user = userInput
            case .failure(let error):
                print("\(String(describing: error)) No data for user \(loginInput)")
                user = nil
            }
        }
        
        do {
            try logIn(correct: correct, user: user)
        } catch LogInError.incorrectInput {
            handleLogInError(error: .incorrectInput)
        } catch LogInError.noDataForUser {
            handleLogInError(error: .noDataForUser)
        } catch {
            print("Something went wrong")
        }
        
        
    }
    
    private func logIn(correct: Bool, user: User?) throws {
        
        if correct {
            print("Correct login and password")
            if let userIdentified = user {
                didLoggedIn?(userIdentified)
                print("Successfully logged in")
            } else {
                throw LogInError.noDataForUser
            }
            
        } else {
            throw LogInError.incorrectInput
        }
        
    }
    
    private func handleLogInError(error: LogInError) {
        switch error {
        case .incorrectInput:
            print("Incorrect login or password")
            let alertController = UIAlertController(title: "Incorrect password or login", message: "Please check your login and passworg and try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try again", style: .default) { _ in
                self.loginTextField.text = nil
                self.passwordTextField.text = nil
            })
            present(alertController, animated: true)
            
        case .noDataForUser:
            print("No profile data for login")
            let loginInput: String = loginTextField.text != nil ? loginTextField.text! : ""
            let alertController = UIAlertController(title: "Cant'find profile data for \(loginInput)", message: "Something went wrong, please, try to log in again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.loginTextField.text = nil
                self.passwordTextField.text = nil
            })
            present(alertController, animated: true)
        }
    }
    
    @objc private func didTapPasswordButton(_ sender: UIButton) {
        
        print("Did tap Password Button")
        
        self.activityIndicator.startAnimating()
        
        loginDelegate?.generateNewPassword(of: 4)
        
        let operation = LoginOperation(loginDelegate: loginDelegate)
        operation.didFinishedPasswordGuessing = {
            let newPassword = $0
            DispatchQueue.main.async { [weak self] in
                self?.passwordTextField.isSecureTextEntry = false
                self?.passwordTextField.text = newPassword
                self?.activityIndicator.stopAnimating()
            }
            
            
        }
        
        let opQueue = OperationQueue()
        opQueue.qualityOfService = .userInitiated
        opQueue.addOperation(operation)
        
        operation.completionBlock = {
            print("Finished password guessing")
        }
        
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

