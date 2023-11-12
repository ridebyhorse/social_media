//
//  LoginFactory.swift
//  social_media
//
//  Created by Мария Нестерова on 10.11.2023.
//

import Foundation

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
