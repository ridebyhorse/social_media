//
//  User.swift
//  social_media
//
//  Created by Мария Нестерова on 08.11.2023.
//

import Foundation
import UIKit

protocol UserService {
    func checkUser(login: String) -> User?
}

class User {
    private(set) var login: String
    private(set) var fullName: String
    private(set) var status: String
    private(set) var avatar: UIImage
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
}
