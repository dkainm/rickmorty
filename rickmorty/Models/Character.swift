//
//  Character.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation
import CoreData

class CharactersResponse: Decodable {
    let pagination: Pagination
    let items: [Character]
    
    enum CodingKeys: String, CodingKey {
        case pagination = "info", items = "results"
    }
}

class Pagination: Decodable {
    let count: Int
    let pages: Int
    private let nextUrl: String?
    private let prevUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case count, pages
        case nextUrl = "next", prevUrl = "prev"
    }
    
    var nextPage: Int? {
        guard let nextUrl = nextUrl else { return nil }
        return Int(nextUrl.components(separatedBy: "=").last ?? "")
    }
    
    var prevPage: Int? {
        guard let prevUrl = prevUrl else { return nil }
        return Int(prevUrl.components(separatedBy: "=").last ?? "")
    }
}

class Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    
    func getFavoriteStatus(completion: (Bool, SavedCharacter?) -> ()) {
        DatabaseManager.shared.fetchCharacters { complete, charactersArray in
            guard complete, let characters = charactersArray else {
                completion(false, nil)
                return
            }
            let character = characters.first(where: {$0.id == id})
            completion(character != nil, character)
        }
    }
    
    func getSavedCharacter(completion: (SavedCharacter?) -> ()) {
        DatabaseManager.shared.fetchCharacters { complete, charactersArray in
            guard complete, let characters = charactersArray else {
                completion(nil)
                return
            }
            completion(characters.first(where: {$0.id == id}))
        }
    }
}

class Location: Decodable {
    let name: String
}
