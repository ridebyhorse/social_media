//
//  TestUserService.swift
//  social_media
//
//  Created by Мария Нестерова on 09.11.2023.
//

import Foundation
import UIKit

enum UserError: Error {
    case noData
}

class TestUserService: UserService {
    
    private var user: User = User(login: "underTheSea", fullName: "Patrick Star", status: "Don't touch me, I'm sterile", avatar: UIImage(named: "Avatar_test")!)
    
    func checkUser(login: String, completion: (Result<User, UserError>) -> Void) {
        if user.login == login {
            completion(.success(user))
            
        } else {
            completion(.failure(.noData))
        }
    }
}
