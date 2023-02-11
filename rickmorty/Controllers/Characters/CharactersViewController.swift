//
//  CharactersViewController.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import UIKit
import SnapKit

class CharactersViewController: UIViewController {
    
    //MARK: Properties
    
    var viewModel: CharactersViewModelType! = CharactersViewModel()
    
    private let apiService = ApiService()
    
    //MARK: UI Elements
    
    private var headerView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(font: .proximaNovaSemibold(size: 28), textColor: .black)
        label.text = "Characters"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchBar: RickMortySearchBar = {
        let searchBar = RickMortySearchBar()
        searchBar.placeholder = "Search character"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - API
    
    private func fetchData() {
        apiService.fetchCharacters { [weak self] (response) in
            guard let `self` = self, let response = response else { return }
            self.viewModel.characters = response.items
            self.tableView.reloadData()
        }
    }
    
    //MARK: - UI Methods
    
    private func configureUI() {
        view.backgroundColor = .background
        
        buildHierarchy()
        configureConstraints()
    }
    
    private func buildHierarchy() {
        view.addSubviews([headerView, searchBar, tableView])
        headerView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56 + topPadding)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
