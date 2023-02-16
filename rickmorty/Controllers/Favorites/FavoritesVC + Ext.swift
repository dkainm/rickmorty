//
//  FavoritesVC + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 16/2/23.
//

import UIKit

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier, for: indexPath) as! CharacterViewCell
        cell.viewModel = CharacterViewCellModel(savedCharacter: viewModel.savedCharacter(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterID = Int(viewModel.savedCharacter(for: indexPath).id)
        apiService.fetchCharacter(id: characterID) { [weak self] (character) in
            guard let character = character else { return }
            let vc = CharacterCardViewController()
            vc.viewModel = CharacterViewModel(character: character)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
