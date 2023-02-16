//
//  DatabaseManager.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import CoreData

class DatabaseManager {
    
    static var shared: DatabaseManager = {
        let instance = DatabaseManager()
        return instance
    }()
    
    private init() {}
    
    func save(character: Character, completion: ((_ finished: Bool) -> ())? = nil) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let savedCharacter = SavedCharacter(context: managedContext)
        savedCharacter.id = Int16(character.id)
        savedCharacter.name = character.name
        savedCharacter.status = character.status
        savedCharacter.species = character.species
        savedCharacter.type = character.type
        savedCharacter.gender = character.gender
        savedCharacter.originName = character.origin.name
        savedCharacter.locationName = character.location.name
        savedCharacter.image = character.image
        
        do {
            try managedContext.save()
            completion?(true)
        } catch {
            print("Failed to save data: ", error.localizedDescription)
            completion?(false)
        }
    }
    
    func save(character: SavedCharacter, completion: ((_ finished: Bool) -> ())? = nil) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let savedCharacter = SavedCharacter(context: managedContext)
        savedCharacter.id = character.id
        savedCharacter.name = character.name
        savedCharacter.status = character.status
        savedCharacter.species = character.species
        savedCharacter.type = character.type
        savedCharacter.gender = character.gender
        savedCharacter.originName = character.originName
        savedCharacter.locationName = character.locationName
        savedCharacter.image = character.image
        do {
            try managedContext.save()
            completion?(true)
        } catch {
            print("Failed to save data: ", error.localizedDescription)
            completion?(false)
        }
    }
    
    func fetchCharacters(completion: (_ complete: Bool, _ charactersArray: [SavedCharacter]?) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCharacter")
        do {
            let charactersArray = try managedContext.fetch(request) as? [SavedCharacter]
            completion(true, charactersArray)
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false, nil)
        }
    }
    
    func delete(_ character: SavedCharacter) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(character)
        do {
            try managedContext.save()
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
        }
    }
}
