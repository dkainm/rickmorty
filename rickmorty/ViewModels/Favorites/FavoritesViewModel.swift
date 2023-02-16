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
    
}
