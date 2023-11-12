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
    
    func ckeckUser(login: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }
    
}
