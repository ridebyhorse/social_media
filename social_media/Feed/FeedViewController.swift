//
//  FeedViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    var showPost: (() -> Void)?
    
    var showAudio: (() -> Void)?
    
    @objc private let model: FeedModel
    
    private let feedStackView: UIStackView = {
        let feedStackView = UIStackView()
        feedStackView.axis = .vertical
        feedStackView.distribution = .equalSpacing
        feedStackView.spacing = 16
        feedStackView.alignment = .center
        
        return feedStackView
    }()
    
    private lazy var showPostButton: CustomButton = {
        let showPostButton = CustomButton(title: "Show videoposts", color: .systemRed, titleColor: .white)
        showPostButton.onTap = {
            self.showPostController()
        }
        
        return showPostButton
    }()
    
    private lazy var doNothingButton: CustomButton = {
        let doNothingButton = CustomButton(title: "Show audionotes", color: .systemYellow, titleColor: .white)
        doNothingButton.onTap = {
            self.showAudionotes()
        }
        
        return doNothingButton
    }()
    
    private lazy var guessWordTextField: UITextField = {
        let guessWordTextField = UITextField()
        guessWordTextField.placeholder = "Guess the word.."
        guessWordTextField.backgroundColor = .white
        guessWordTextField.textColor = .black
        guessWordTextField.layer.borderColor = UIColor.darkGray.cgColor
        guessWordTextField.layer.borderWidth = 1
        guessWordTextField.layer.cornerRadius = 8
        guessWordTextField.setSidePaddingPoints(8)
        
        return guessWordTextField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let checkGuessButton = CustomButton(title: "Check guess", color: .purple, titleColor: .white)
        checkGuessButton.onTap = {
            self.checkWord()
        }
        
        return checkGuessButton
    }()
    
    private lazy var guessAnswerLabel: UILabel = {
        let guessAnswerLabel = UILabel()
        guessAnswerLabel.font = .systemFont(ofSize: 12, weight: .regular)
        guessAnswerLabel.text = " "
        
        return guessAnswerLabel
    }()
    
    init(model: FeedModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
        configure()
        
    }
    
    private func setup() {
        view.addSubview(feedStackView)
        feedStackView.addArrangedSubview(showPostButton)
        feedStackView.addArrangedSubview(doNothingButton)
        feedStackView.addArrangedSubview(guessWordTextField)
        feedStackView.addArrangedSubview(checkGuessButton)
        feedStackView.addArrangedSubview(guessAnswerLabel)
        
        
        feedStackView.translatesAutoresizingMaskIntoConstraints = false
        for view in feedStackView.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            feedStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            feedStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showPostButton.heightAnchor.constraint(equalToConstant: 40),
            showPostButton.widthAnchor.constraint(equalToConstant: 180),
            doNothingButton.heightAnchor.constraint(equalTo: showPostButton.heightAnchor),
            doNothingButton.widthAnchor.constraint(equalTo: showPostButton.widthAnchor),
            guessWordTextField.heightAnchor.constraint(equalTo: doNothingButton.heightAnchor),
            guessWordTextField.widthAnchor.constraint(equalToConstant: 240),
            checkGuessButton.heightAnchor.constraint(equalTo: guessWordTextField.heightAnchor),
            checkGuessButton.widthAnchor.constraint(equalTo: doNothingButton.widthAnchor)
        ])
        
    }
    
    private func configure() {
        model.observation = observe(\.model.passwordIsCorrect) { object, change in
            if object.model.passwordIsCorrect {
                self.guessAnswerLabel.textColor = .green
                self.guessAnswerLabel.text = "Correct!"
            } else {
                self.guessAnswerLabel.textColor = .red
                self.guessAnswerLabel.text = "Ops! Try again"
            }
            
        }
    }
    
    private func showPostController() {
        print("Did tap Show Videoposts button")
        showPost?()
        
    }
    
    private func showAudionotes() {
        print("Did tap Show Audionotes button")
        showAudio?()
    }
    
    private func checkWord() {
        print("Did tap Check Guess button")
        guard let wordToCheck = guessWordTextField.text else { return }
        print("Guessing word \"\(wordToCheck)\"")
        model.check(word: wordToCheck)
        
        guessWordTextField.text = nil
    }
    
}

extension UITextField {
    func setSidePaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
    
}
