//
//  PostTableViewCell.swift
//  social_media
//
//  Created by Мария Нестерова on 19.10.2023.
//

import UIKit
import iOSIntPackage


class PostTableViewCell: UITableViewCell {
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        
        return authorLabel
    }()
    
    private lazy var imagePost: UIImageView = {
        let imagePost = UIImageView()
        imagePost.clipsToBounds = true
        imagePost.contentMode = .scaleAspectFill
        
        return imagePost
    }()
    
    private lazy var textDescriptionPost: UILabel = {
        let textDescriptionPost = UILabel()
        textDescriptionPost.font = .systemFont(ofSize: 14, weight: .regular)
        textDescriptionPost.textColor = .systemGray
        textDescriptionPost.textAlignment = .justified
        textDescriptionPost.numberOfLines = 0
        
        
        return textDescriptionPost
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = .systemFont(ofSize: 16, weight: .regular)
        likesLabel.textColor = .black
        likesLabel.textAlignment = .left
        
        return likesLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = .systemFont(ofSize: 16, weight: .regular)
        viewsLabel.textColor = .black
        viewsLabel.textAlignment = .right
        
        return viewsLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(authorLabel)
        contentView.addSubview(imagePost)
        contentView.addSubview(textDescriptionPost)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        for view in contentView.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imagePost.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imagePost.heightAnchor.constraint(equalTo: imagePost.widthAnchor),
            imagePost.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            imagePost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            textDescriptionPost.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 16),
            textDescriptionPost.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            textDescriptionPost.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            
            likesLabel.leadingAnchor.constraint(equalTo: textDescriptionPost.leadingAnchor),
            likesLabel.topAnchor.constraint(equalTo: textDescriptionPost.bottomAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: textDescriptionPost.centerXAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            viewsLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: textDescriptionPost.trailingAnchor),
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor)
        ])
    }
    
    func update(author: String, namePicForPost: String, text: String, likesCount: Int, viewsCount: Int, filter: ColorFilter) {
        authorLabel.text = author
        if let image = UIImage(named: namePicForPost) {
            let processor = ImageProcessor()
            processor.processImage(sourceImage: image, filter: filter) {result in
                self.imagePost.image = result
                print("Applied filter \(filter) for \(namePicForPost) image")
            }
        }
        textDescriptionPost.text = text
        likesLabel.text = "Likes: \(likesCount)"
        viewsLabel.text = "Views: \(viewsCount)"
    }
    

}
