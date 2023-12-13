//
//  CurrentUserService.swift
//  social_media
//
//  Created by Мария Нестерова on 08.11.2023.
//

import Foundation
import UIKit

class CurrentUserService: UserService {
    
    private var user: User = User(login: "pineapple", fullName: "Sponge Bob", status: "Are you ready, kids?", avatar: UIImage(named: "Avatar")!)
    
    func checkUser(login: String, completion: (Result<User, UserError>) -> Void) {
        if user.login == login {
            completion(.success(user))
            
        } else {
            completion(.failure(.noData))
        }
    }
    
}
