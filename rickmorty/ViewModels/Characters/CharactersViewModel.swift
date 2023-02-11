//
//  CharactersViewModel.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation

protocol CharactersViewModelType {
    var characters: [Character] { get set }
}

class CharactersViewModel: CharactersViewModelType {
    
    var characters: [Character] = []
    
}
