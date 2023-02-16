//
//  NetworkRoute.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation

protocol NetworkRouteProtocol {
    var request: URLRequest? { get }
}

enum NetworkRoute: NetworkRouteProtocol {
    case characters(page: Int?, parameters: SearchParameters)
    case character(id: Int)
    
    var request: URLRequest? {
        return URLRequestFactory().getRequest(for: self)
    }
}
