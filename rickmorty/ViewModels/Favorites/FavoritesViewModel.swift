//
//  FavoritesViewModel.swift
//  rickmorty
//
//  Created by Alex Rudoi on 16/2/23.
//

import UIKit
import CoreData

protocol FavoritesViewModelType {
    var savedCharacters: [SavedCharacter] { get set }
    var headerHeight: CGFloat { get }
    func numberOfRows(for section: Int) -> Int
    func savedCharacter(for indexPath: IndexPath) -> SavedCharacter
}

class FavoritesViewModel: FavoritesViewModelType {

    private let apiService = ApiService()
    private let databaseManager = DatabaseManager.shared
    
    var savedCharacters: [SavedCharacter] = []
    
    var headerHeight: CGFloat {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        return 53 + topPadding
    }
    
    func numberOfRows(for section: Int) -> Int {
        return savedCharacters.count
    }
    
    func savedCharacter(for indexPath: IndexPath) -> SavedCharacter {
        return savedCharacters[indexPath.row]
    }
    
    func fetchData(completion: @escaping (Bool) -> ()) {
        databaseManager.fetchCharacters { [weak self] (complete, charactersArray) in
            guard let `self` = self, let characters = charactersArray, complete else {
                completion(false)
                return
            }
            self.savedCharacters = characters
            completion(characters.isEmpty)
            
        }
    }
    
    func fetchCharacter(id: Int, completion: @escaping (Character?) -> ()) {
        apiService.fetchCharacter(id: id) { (character) in
            completion(character)
        }
    }
    
}
