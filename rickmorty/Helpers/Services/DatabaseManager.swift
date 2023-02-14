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
        savedCharacter.image = character.image
        
        do {
            try managedContext.save()
            print("Data saved")
            completion?(true)
        } catch {
            print("Failed to save data: ", error.localizedDescription)
            completion?(false)
        }
    }
    
    func fetchSavedCharacters(completion: (_ complete: Bool, _ charactersArray: [SavedCharacter]?) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCharacter")
        do {
            let charactersArray = try managedContext.fetch(request) as? [SavedCharacter]
            print("Data fetched, no issue")
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
            print("Data deleted")
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
        }
    }
}
