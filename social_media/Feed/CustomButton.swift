//
//  CustomButton.swift
//  social_media
//
//  Created by Мария Нестерова on 28.11.2023.
//

import UIKit

class CustomButton: UIButton {
    
    var onTap: (() -> Void)?

    init(title: String, color: UIColor, titleColor: UIColor) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 8
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func didTapButton(_ sender: UIButton) {
        onTap?()
    }
    
}
