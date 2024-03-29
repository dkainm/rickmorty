//
//  CharacterViewModel.swift
//  rickmorty
//
//  Created by Alex Rudoi on 16/2/23.
//

import UIKit
import CoreData

protocol CharacterViewModelType {
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var type: String { get }
    var gender: String { get }
    var originName: String { get }
    var locationName: String { get }
    var image: String? { get }
    func getFavoriteStatus(completion: (Bool) -> ())
    func saveCharacter()
    func deleteCharacter()
}

class CharacterViewModel: CharacterViewModelType {
    
    let databaseManager = DatabaseManager.shared
    
    var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var name: String {
        return character.name.markIfEmpty()
    }
    
    var status: String {
        return character.status.capitalized.markIfEmpty()
    }
    
    var species: String {
        return character.species.markIfEmpty()
    }
    
    var type: String {
        return character.type.markIfEmpty()
    }
    
    var gender: String {
        return character.gender.markIfEmpty()
    }
    
    var originName: String {
        return character.origin.name.markIfEmpty()
    }
    
    var locationName: String {
        return character.location.name.markIfEmpty()
    }
    
    var image: String? {
        return character.image
    }
    
    func getFavoriteStatus(completion: (Bool) -> ()) {
        character.getFavoriteStatus() { isFavorite, _ in
            completion(isFavorite)
        }
    }
    
    func saveCharacter() {
        databaseManager.save(character: character)
    }
    
    func deleteCharacter() {
        character.getSavedCharacter { [weak self] (savedCharacter) in
            guard let savedCharacter = savedCharacter else { return }
            self?.databaseManager.delete(savedCharacter)
        }
    }
    
}
