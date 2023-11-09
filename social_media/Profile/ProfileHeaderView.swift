//
//  ProfileHeaderView.swift
//  social_media
//
//  Created by Мария Нестерова on 13.10.2023.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    private let avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.layer.borderWidth = 2
        avatarView.contentMode = .scaleAspectFill
        
        return avatarView
    }()
    
    private let ava: UIImageView = {
        let ava = UIImageView()
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
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .black
        statusLabel.alpha = 0.5
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return statusLabel
    }()
    
    
    private let setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.setTitle("Change status", for: .normal)
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
        setStatusTextField.placeholder = "Type sth to change status..."
        setStatusTextField.textColor = .black
        setStatusTextField.font = .systemFont(ofSize: 14, weight: .regular)
        
        return setStatusTextField
    }()
    
    init(frame: CGRect, user: User) {
        nameLabel.text = user.fullName
        statusLabel.text = user.status
        avatarView.image = user.avatar
        ava.image = user.avatar
        
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
        
        avatarView.snp.makeConstraints {
            $0.width.height.equalTo(110)
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(24)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView).offset(8)
            $0.leading.equalTo(avatarView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        textFieldBackgroundView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.trailing.equalTo(statusLabel)
            $0.bottom.equalTo(avatarView).inset(8)
        }
        
        setStatusTextField.snp.makeConstraints {
            $0.top.equalTo(textFieldBackgroundView).offset(5)
            $0.leading.equalTo(textFieldBackgroundView).offset(7)
            $0.trailing.equalTo(textFieldBackgroundView).inset(12)
        }
        
        setStatusButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(avatarView.snp.bottom).offset(16)
            $0.leading.equalTo(avatarView)
            $0.trailing.equalTo(textFieldBackgroundView)
        }
        
        avatarCloseUpView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
        closeAvatarButton.snp.makeConstraints {
            $0.top.equalTo(avatarView)
            $0.trailing.equalTo(nameLabel)
        }
        
    
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
    
    @objc func didTapCloseAvatar() {
        
        print("Did tap Close Avatar Button")
        closeAvatarButton.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            print("Close avatar animation")
            self.delegate?.didCloseAvatar()
            self.avatarCloseUpView.alpha = 0
            self.ava.center = self.avatarView.center
            self.ava.bounds = self.avatarView.bounds
            self.ava.layer.cornerRadius = self.avatarView.layer.cornerRadius
            self.ava.layer.borderWidth = self.avatarView.layer.borderWidth
        }) { _ in
            self.layoutIfNeeded()
            self.avatarView.alpha = 1
            self.ava.alpha = 0
        }
        
    }
    
}
