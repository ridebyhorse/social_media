//
//  Checker.swift
//  social_media
//
//  Created by Мария Нестерова on 10.11.2023.
//

import Foundation

final class Checker {
    
    static var shared: Checker {Checker()}
    private let login: String
    private let password: String = "12345678"
    private static var generatedPassword: String?
    
    func checkLogin(login: String) -> Bool {
        if self.login == login {
            return true
        } else {
            return false
        }
    }
    
    func checkPassword(password: String) -> Bool {
        if let generatedPassword = Checker.generatedPassword {
            if generatedPassword == password {
                return true
            } else {
                return false
            }
        } else {
            if self.password == password {
                return true
            } else {
                return false
            }
        }
        
    }
    
    private init() {
        
        #if DEBUG
            login = "underTheSea"
        #else
            login = "pineapple"
        #endif
        
    }
    
    func generateNewPassword(of numberOfChars: Int) {
        var newPassword = ""
        for _ in 1...numberOfChars {
            newPassword.append(letters[Int.random(in: 1..<letters.count)])
        }
        Checker.generatedPassword = newPassword
    }
}
