//
//  CharactersViewModel.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import UIKit

protocol CharactersViewModelType {
    var characters: [Character] { get set }
    var pagination: Pagination? { get set }
    var searchParameters: SearchParameters { get }
    var isFilteringMode: Bool { get set }
    var headerHeight: CGFloat { get }
    var numberOfSections: Int { get }
    func numberOfRows(for section: Int) -> Int
    func character(for indexPath: IndexPath) -> Character
}

class CharactersViewModel: CharactersViewModelType {
    
    private let apiService = ApiService()
    
    var characters: [Character] = []
    var pagination: Pagination?
    var searchParameters = SearchParameters()
    
    var isFilteringMode = false
    
    var headerHeight: CGFloat {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        return 53 + topPadding
    }
    
    var numberOfSections: Int {
        return (pagination?.nextPage == nil) ? 1 : 2
    }
    
    func numberOfRows(for section: Int) -> Int {
        return section == 0 ? characters.count : 1
    }
    
    func character(for indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
    
    func fetchData(page: Int? = nil, completion: @escaping () -> ()) {
        apiService.fetchCharacters(page: page, parameters: searchParameters) { [weak self] (response) in
            guard let `self` = self, let response = response else { return }
            
            if let nextPage = self.pagination?.nextPage,
               response.pagination.prevPage == nextPage - 1 {
                self.characters += response.items
            } else {
                self.characters = response.items
            }
            
            self.pagination = response.pagination
            completion()
        }
    }
    
}
