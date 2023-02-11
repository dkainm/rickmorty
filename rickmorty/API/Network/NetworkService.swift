//
//  NetworkService.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation
import Alamofire

protocol Networking {
    func request(route: NetworkRouteProtocol, completion: @escaping NetworkResponse)
}

class NetworkService: Networking {
    
    func request(route: NetworkRouteProtocol, completion: @escaping NetworkResponse) {
        guard let request = route.request else { return }

        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                let networkError = NetworkError.responseStatusError(status: 0, message: error.localizedDescription)
                completion(.failure(networkError))
            }
        }
    }
    
}
