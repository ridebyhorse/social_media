//
//  PhotosTableViewCell.swift
//  social_media
//
//  Created by Мария Нестерова on 20.10.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Photos"
        photosLabel.textColor = .black
        photosLabel.font = .systemFont(ofSize: 24, weight: .bold)
        photosLabel.textAlignment = .left
        
        return photosLabel
    }()
    
    private lazy var indicator: UIImageView = {
        let indicator = UIImageView()
        indicator.image = UIImage(systemName: "arrow.right")
        indicator.clipsToBounds = true
        
        return indicator
    }()
    
    private lazy var photosStackView: UIStackView = {
        let photosStackView = UIStackView()
        photosStackView.axis = .horizontal
        photosStackView.distribution = .equalSpacing
        photosStackView.spacing = 8
        
        return photosStackView
    }()
    
    private lazy var photo1: UIImageView = {
        let photo1 = UIImageView()
        photo1.clipsToBounds = true
        photo1.layer.cornerRadius = 6
        
        return photo1
    }()
    
    private lazy var photo2: UIImageView = {
        let photo2 = UIImageView()
        photo2.clipsToBounds = true
        photo2.layer.cornerRadius = 6
        
        return photo2
    }()
    
    private lazy var photo3: UIImageView = {
        let photo3 = UIImageView()
        photo3.clipsToBounds = true
        photo3.layer.cornerRadius = 6
        
        return photo3
    }()
    
    private lazy var photo4: UIImageView = {
        let photo4 = UIImageView()
        photo4.clipsToBounds = true
        photo4.layer.cornerRadius = 6
        
        return photo4
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(indicator)
        contentView.addSubview(photosStackView)
        photosStackView.addArrangedSubview(photo1)
        photosStackView.addArrangedSubview(photo2)
        photosStackView.addArrangedSubview(photo3)
        photosStackView.addArrangedSubview(photo4)
        
        for view in contentView.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        for photo in photosStackView.arrangedSubviews {
            photo.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            indicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            indicator.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            
            photosStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photosStackView.leadingAnchor.constraint(equalTo: photosLabel.leadingAnchor),
            photosStackView.trailingAnchor.constraint(equalTo: indicator.trailingAnchor),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            photo1.widthAnchor.constraint(equalTo: photosStackView.widthAnchor, multiplier: 0.25, constant: -6),
            photo2.widthAnchor.constraint(equalTo: photo1.widthAnchor),
            photo3.widthAnchor.constraint(equalTo: photo1.widthAnchor),
            photo4.widthAnchor.constraint(equalTo: photo1.widthAnchor),
            photo1.heightAnchor.constraint(equalTo: photo1.widthAnchor, multiplier: 0.75),
            photo2.heightAnchor.constraint(equalTo: photo1.heightAnchor),
            photo3.heightAnchor.constraint(equalTo: photo1.heightAnchor),
            photo4.heightAnchor.constraint(equalTo: photo1.heightAnchor),
            
        ])
        
    }
    
    
    func update(photos: [UIImage]) {
        var i = 0
        for imageView in photosStackView.arrangedSubviews {
            if let image = imageView as? UIImageView {
                image.image = photos[i]
                i += 1
            }
        }
    }
    
}
