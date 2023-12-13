//
//  Letters.swift
//  social_media
//
//  Created by Мария Нестерова on 11.12.2023.
//

import Foundation

private let aScalars = "!".unicodeScalars
private let aCode = aScalars[aScalars.startIndex].value

public let letters: [Character] = (0..<90).map {
    i in
    Character(UnicodeScalar(aCode + i)!)
}
