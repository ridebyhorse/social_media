//
//  LoginOperation.swift
//  social_media
//
//  Created by Мария Нестерова on 11.12.2023.
//

import Foundation

class LoginOperation: Operation {
    
    var didFinishedPasswordGuessing: ((String) -> Void)?
    
    private var loginDelegate: LoginViewControllerDelegate?
    
    init(loginDelegate: LoginViewControllerDelegate?) {
        self.loginDelegate = loginDelegate
    }
    
    override func main() {
        guard !isCancelled else { return }
        guessPassword()
    }
    
    private func guessPassword() {
        var passwordToCheck = ""
        outerLoop: for a in letters {
            for b in letters {
                for c in letters {
                    for d in letters {
                        passwordToCheck = String(a) + String(b) + String(c) + String(d)
                        guard let correct = loginDelegate?.checkPassword(password: passwordToCheck) else { return }
                        if correct {
                            print("Found password: \(passwordToCheck)")
                            didFinishedPasswordGuessing!(passwordToCheck)
                            break outerLoop
                        }
                    }
                }
            }
        }
    }
    
}
