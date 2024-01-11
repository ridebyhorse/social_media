//
//  NetworkService.swift
//  social_media
//
//  Created by Мария Нестерова on 17.12.2023.
//

import Foundation

enum AppConfiguration {
    case films(url: URL)
    case people(url: URL)
    case planets(url: URL)
}
enum AppConfiguration2: String, CaseIterable {
    case films = "https://swapi.dev/api/films/"
    case people = "https://swapi.dev/api/people/"
    case planets = "https://swapi.dev/api/planets/"
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration2) {
        if let url = URL(string: configuration.rawValue) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data {
                    if let decodedString = String(data: data, encoding: .utf8) {
                        print("Data: \(decodedString)")
                    } else {
                        print("Data is nil")
                    }
                }
                
                if let response {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Response:")
                        print("Header fields: \(httpResponse.allHeaderFields)")
                        print("Status code: \(httpResponse.statusCode)")
                    }
                } else {
                    print("Response is nil")
                }
                
                if let error {
                    print(error.localizedDescription)
                } else {
                    print("No errors")
                }
            }
            
            task.resume()
        } else {
            print("Wrong url")
        }
        
    }
}
