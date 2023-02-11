//
//  NetworkManager.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation

protocol NetworkManagement {
    func fetchData<T: Decodable>(route: NetworkRoute, response: @escaping (T?) -> Void)
}

class NetworkManager: NetworkManagement {
    
    private var networking: Networking!
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchData<T: Decodable>(route: NetworkRoute, response: @escaping (T?) -> Void) {
        networking.request(route: route) { fetchedData in
            switch fetchedData {
            case .success(let data):
                print("DEBUG: fetchedData", String(data: data, encoding: .utf8) ?? "NO DATA", "\n")
                let decoded = self.decodeJSON(type: T.self, data: data)
                response(decoded)
            case .failure(let error):
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data) -> T? {
        let model = try? JSONDecoder().decode(T.self, from: data)
        return model
    }
    
}

