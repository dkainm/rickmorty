//
//  CharactersVC + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 11/2/23.
//

import UIKit

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier, for: indexPath) as! CharacterViewCell
            cell.configure(with: viewModel.characters[indexPath.row])
            return cell
        default:
            guard let pagination = viewModel.pagination else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: PaginationViewCell.identifier, for: indexPath) as! PaginationViewCell
            cell.configure(with: pagination)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 76 : 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        default:
            fetchData(page: viewModel.pagination?.nextPage)
        }
    }
    
}

extension CharactersViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            viewModel.searchParameters.name = nil
            fetchData()
            return
        }
        viewModel.searchParameters.name = text
        fetchData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}
