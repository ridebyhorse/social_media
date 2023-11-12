//
//  TestUserService.swift
//  social_media
//
//  Created by Мария Нестерова on 09.11.2023.
//

import Foundation
import UIKit

class TestUserService: UserService {
    
    private var user: User = User(login: "underTheSea", fullName: "Patrick Star", status: "Don't touch me, I'm sterile", avatar: UIImage(named: "Avatar_test")!)
    
    func ckeckUser(login: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }
}
