//
//  Coordinator.swift
//  social_media
//
//  Created by Мария Нестерова on 01.12.2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigation: UINavigationController { get }
    var onComplete: (() -> Void)? { get set }
    func start()
}

