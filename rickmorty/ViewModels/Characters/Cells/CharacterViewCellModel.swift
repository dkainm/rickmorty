//
//  CharacterViewCellModel.swift
//  rickmorty
//
//  Created by Alex Rudoi on 16/2/23.
//

import CoreData

protocol CharacterViewCellModelType {
    var name: String? { get }
    var status: String? { get }
    var image: String? { get }
    func getFavoriteStatus(completion: @escaping (Bool) -> ())
}

class CharacterViewCellModel: CharacterViewCellModelType {
    
    var character: Character?
    var savedCharacter: SavedCharacter?
    
    init(character: Character? = nil, savedCharacter: SavedCharacter? = nil) {
        self.character = character
        self.savedCharacter = savedCharacter
    }
    
    var name: String? {
        if let character = character {
            return character.name
        } else if let savedCharacter = savedCharacter {
            return savedCharacter.name
        }
        return nil
    }
    
    var status: String? {
        if let character = character {
            return character.status.capitalized
        } else if let savedCharacter = savedCharacter {
            return savedCharacter.status?.capitalized
        }
        return nil
    }
    
    var image: String? {
        if let character = character {
            return character.image
        } else if let savedCharacter = savedCharacter {
            return savedCharacter.image
        }
        return nil
    }
    
    func getFavoriteStatus(completion: (Bool) -> ()) {
        if let character = character {
            character.getFavoriteStatus { isFavorite, _ in
                completion(isFavorite)
            }
        } else {
            completion(true)
        }
    }
    
}
