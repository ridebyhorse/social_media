//
//  ProfileHeaderView.swift
//  social_media
//
//  Created by Мария Нестерова on 13.10.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    private let avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.image = UIImage(named: "Avatar")
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.layer.borderWidth = 2
        avatarView.contentMode = .scaleAspectFill
        
        return avatarView
    }()
    
    private let ava: UIImageView = {
        let ava = UIImageView()
        ava.image = UIImage(named: "Avatar")
        ava.layer.borderColor = UIColor.white.cgColor
        ava.layer.borderWidth = 2
        ava.contentMode = .scaleAspectFill
        ava.alpha = 0
        
        return ava
    }()
    
    let avatarCloseUpView: UIView = {
        let avatarCloseUpView = UIView()
        avatarCloseUpView.backgroundColor = .darkGray
        avatarCloseUpView.alpha = 0
        
        return avatarCloseUpView
    }()
    
    let closeAvatarButton: UIButton = {
        let closeAvatarButton = UIButton(type: .close)
        closeAvatarButton.alpha = 0
        closeAvatarButton.addTarget(self, action: #selector(didTapCloseAvatar), for: .touchUpInside)
        
        return closeAvatarButton
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Sponge Bob"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = ""
        statusLabel.textColor = .black
        statusLabel.alpha = 0.5
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return statusLabel
    }()
    
    
    private let setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.titleLabel?.textColor = .white
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 8
        setStatusButton.layer.shadowOffset = .init(width: 3, height: 3)
        setStatusButton.layer.shadowRadius = 8
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.2
        setStatusButton.addTarget(self, action: #selector(didTapSetStatusButton), for: .touchUpInside)
        
        return setStatusButton
    }()
    
    private let textFieldBackgroundView: UIView = {
        let textFieldBackgroundView = UIView()
        textFieldBackgroundView.backgroundColor = .white
        textFieldBackgroundView.layer.cornerRadius = 8
        textFieldBackgroundView.layer.borderColor = UIColor.black.cgColor
        textFieldBackgroundView.layer.borderWidth = 1
        
        return textFieldBackgroundView
    }()
    
    private let setStatusTextField: UITextField = {
        let setStatusTextField = UITextField()
        setStatusTextField.placeholder = "Type here sth to set status"
        setStatusTextField.textColor = .black
        setStatusTextField.font = .systemFont(ofSize: 14, weight: .regular)
        
        return setStatusTextField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.layer.cornerRadius = avatarView.frame.width / 2
        avatarView.clipsToBounds = true
        ava.clipsToBounds = true
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(didTapAvatar))
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(recognizer)
    }
  
    
    private func setupViews() {
        
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(textFieldBackgroundView)
        addSubview(setStatusTextField)
        addSubview(avatarCloseUpView)
        addSubview(closeAvatarButton)
        

        for view in self.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(ava)
        
        NSLayoutConstraint.activate([
            
            
            avatarView.widthAnchor.constraint(equalToConstant: 110),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: avatarView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            textFieldBackgroundView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -8),
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: 30),
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            
            setStatusTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 7),
            setStatusTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -12),
            setStatusTextField.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor, constant: 5),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            
            avatarCloseUpView.widthAnchor.constraint(equalTo: widthAnchor),
            avatarCloseUpView.heightAnchor.constraint(equalTo: heightAnchor),
            
            closeAvatarButton.topAnchor.constraint(equalTo: avatarView.topAnchor),
            closeAvatarButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
        
        
    }
    
    @objc func didTapSetStatusButton() {
        print("Did tap Set Status Button")
        if let newStatus = setStatusTextField.text {
            statusLabel.text = newStatus
            print("Changed status to '\(newStatus)'")
        } else {
            statusLabel.text = ""
            print("Cleared status, nothing were typed in text field")
        }
        
        setStatusTextField.text = ""
    }
    
    @objc func didTapCloseAvatar() {
        
        print("Did tap Close Avatar Button")
        self.layoutIfNeeded()
        closeAvatarButton.alpha = 0

        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2) {
            
            print("Close avatar animation")
            self.delegate?.didCloseAvatar()
            self.avatarCloseUpView.alpha = 0
            self.ava.center = self.avatarView.center
            self.ava.bounds = self.avatarView.bounds
            self.ava.layer.cornerRadius = self.avatarView.layer.cornerRadius
            self.ava.layer.borderWidth = self.avatarView.layer.borderWidth
        }
        
        avatarView.alpha = 1
        ava.alpha = 0
    }
    
    @objc func didTapAvatar(_ gesture: UITapGestureRecognizer) {
        print("Did tap Avatar")
        
        self.delegate?.didTapAvatar()
        self.ava.alpha = 1
        self.avatarView.alpha = 0
        ava.frame = avatarView.frame
        ava.layer.cornerRadius = avatarView.frame.width / 2
        self.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2) {
            print("Avatar animation")
            self.avatarCloseUpView.alpha = 0.8
            self.ava.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            self.ava.bounds = CGRect(origin: self.bounds.origin, size: CGSize(width: self.bounds.width * 0.9, height: self.bounds.width * 0.9))
            self.ava.layer.cornerRadius = 0
            self.ava.layer.borderWidth = 0
        }
        
        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.2) {
            print("Close button animation")
            self.closeAvatarButton.alpha = 1
        }
            
    }
    
}
