//
//  ProfileHeaderView.swift
//  social_media
//
//  Created by Мария Нестерова on 13.10.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.image = UIImage(named: "Avatar")
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.layer.borderWidth = 2
        avatarView.contentMode = .scaleAspectFill
        
        return avatarView
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
    
    
    private let showStatusButton: UIButton = {
        let showStatusButton = UIButton()
        showStatusButton.setTitle("Set status", for: .normal)
        showStatusButton.titleLabel?.textColor = .white
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.layer.cornerRadius = 8
        showStatusButton.layer.shadowOffset = .init(width: 3, height: 3)
        showStatusButton.layer.shadowRadius = 8
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowOpacity = 0.2
        showStatusButton.addTarget(self, action: #selector(didTapSetStatusButton), for: .touchUpInside)
        
        return showStatusButton
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
    }
    
    private func setupViews() {
        
        self.addSubview(avatarView)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(showStatusButton)
        self.addSubview(textFieldBackgroundView)
        self.addSubview(setStatusTextField)

        for view in self.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            avatarView.widthAnchor.constraint(equalToConstant: 100),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: avatarView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            showStatusButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            showStatusButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            showStatusButton.heightAnchor.constraint(equalToConstant: 40),
            
            textFieldBackgroundView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -8),
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: 30),
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            setStatusTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 7),
            setStatusTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -12),
            setStatusTextField.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor, constant: 5),
            setStatusTextField.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: -4)
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
    

}
