//
//  URLRequestFactory.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation
 
class URLRequestFactory {
    
    private var components = NetworkEnvironment.development.urlComponents
    
    func getRequest(for route: NetworkRouteProtocol) -> URLRequest? {
        guard let theRoute = route as? NetworkRoute else { return nil }
        switch theRoute {
        
        case .characters(let page, let parameters):
            return getCharactersRequest(page: page, parameters: parameters)
            
        }
    }
    
    private func getCharactersRequest(page: Int?, parameters: SearchParameters) -> URLRequest? {
        components.path += "/api"
        components.path += "/character"
        components.queryItems = []
        if let page = page {
            components.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        if let name = parameters.name {
            components.queryItems?.append(URLQueryItem(name: "name", value: name))
        }
        if let status = parameters.status {
            components.queryItems?.append(URLQueryItem(name: "status", value: status))
        }
        if let species = parameters.species {
            components.queryItems?.append(URLQueryItem(name: "species", value: species))
        }
        if let type = parameters.type {
            components.queryItems?.append(URLQueryItem(name: "type", value: type))
        }
        if let gender = parameters.gender {
            components.queryItems?.append(URLQueryItem(name: "gender", value: gender))
        }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
