//
//  ApiService.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation

class ApiService {
    
    private var networkManager: NetworkManagement!
    
    init(networkManager: NetworkManagement = NetworkManager()) {
        self.networkManager = networkManager
    }
        
    func fetchCharacters(page: Int? = nil, parameters: SearchParameters, completion: @escaping(CharactersResponse?) -> Void) {
        let route = NetworkRoute.characters(page: page, parameters: parameters)
        networkManager.fetchData(route: route, response: completion)
    }
}
