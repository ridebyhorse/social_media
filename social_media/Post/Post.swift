//
//  Post.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import Foundation

public struct Post {
    public let author: String
    public var description: String
    public var imageName: String
    public var likesCount: Int
    public var viewsCount: Int
    
    public init(author: String, description: String, imageName: String, likesCount: Int, viewsCount: Int) {
        self.author = author
        self.description = description
        self.imageName = imageName
        self.likesCount = likesCount
        self.viewsCount = viewsCount
    }
}
