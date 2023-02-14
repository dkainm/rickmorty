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
    var headerHeight: CGFloat { get }
    var numberOfSections: Int { get }
    func numberOfRows(for section: Int) -> Int
}

class CharactersViewModel: CharactersViewModelType {
    
    var characters: [Character] = []
    var pagination: Pagination?
    var searchParameters = SearchParameters()
    
    var headerHeight: CGFloat {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        return 53 + topPadding
    }
    
    var numberOfSections: Int {
        return pagination?.nextPage == nil ? 1 : 2
    }
    
    func numberOfRows(for section: Int) -> Int {
        return section == 0 ? characters.count : 1
    }
    
}
