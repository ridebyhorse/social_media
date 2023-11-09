//
//  TestUserService.swift
//  social_media
//
//  Created by Мария Нестерова on 09.11.2023.
//

import Foundation
import UIKit

class TestUserService: UserService {
    
    private var user: User = User(login: "underTheSea", fullName: "Patrick Star", status: "Don't Touch Me, I'm Sterile", avatar: UIImage(named: "Avatar_test")!)
    
    func checkUser(login: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }
}
