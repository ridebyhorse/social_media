//
//  FeedModel.swift
//  social_media
//
//  Created by Мария Нестерова on 30.11.2023.
//

import Foundation

class FeedModel: NSObject {
    private let password = "swift"
    
    @objc dynamic var passwordIsCorrect: Bool = false
    
    var observation: NSKeyValueObservation?
    
    func check(word: String) {
        passwordIsCorrect = password == word
        
        if passwordIsCorrect {
            print("Right guess")
        } else {
            print("Wrong guess")
        }
    }
}
