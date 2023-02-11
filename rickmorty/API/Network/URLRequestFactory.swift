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
        
        case .characters(let page):
            return getCharactersRequest(page: page)
            
        }
    }
    
    private func getCharactersRequest(page: Int?) -> URLRequest? {
        components.path += "/api"
        components.path += "/character"
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
