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
    private let password: String
    
    func check(login: String, password: String) -> Bool {
        if self.login == login && self.password == password {
            return true
        } else {
            return false
        }
    }
    
    private init() {
        #if DEBUG
            login = "underTheSea"
            password = "12345678"
        #else
            login = "pineapple"
            password = "12345678"
        #endif
        
    }
}
