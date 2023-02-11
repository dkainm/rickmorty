//
//  NetworkEnvironment.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation

enum NetworkEnvironment {
    
    case development
    
    var host: String {
        return urlComponents.string ?? ""
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        return components
    }
    
}
