//
//  ProfileViewModel.swift
//  social_media
//
//  Created by Мария Нестерова on 01.12.2023.
//

import Foundation
import StorageService

class ProfileViewModel: ProfileViewOutput {
    
    var onNewDataInput: (() -> Void)?
    
    private var model: ProfileModel
    
    var user: User?
    
    var photoData = [String]()
    
    var posts = [Post]() {
        didSet {
            print("Did recieve new post data")
            onNewDataInput?()
        }
    }
    
    init(model: ProfileModel) {
        self.model = model
        configure()
    }
    
    private func configure() {
        
        user = model.user
        
        for i in 0..<model.authorData.count {
            posts.append(Post(author: model.authorData[i], description: model.textData[i], imageName: model.photoData[i], likesCount: model.likeData[i], viewsCount: model.viewData[i]))
        }
        
        for i in 1...20 {
            photoData.append(String(i))
        }
    }
}
