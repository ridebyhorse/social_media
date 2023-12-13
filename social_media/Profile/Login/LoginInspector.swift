//
//  LoginInspector.swift
//  social_media
//
//  Created by Мария Нестерова on 10.11.2023.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct LoginInspector: LoginViewControllerDelegate {
    func checkLogin(login: String) -> Bool {
        Checker.shared.checkLogin(login: login)
    }
    func checkPassword(password: String) -> Bool {
        Checker.shared.checkPassword(password: password)
    }
    
    func generateNewPassword(of numberOfChars: Int) {
        Checker.shared.generateNewPassword(of: numberOfChars)
    }
}
