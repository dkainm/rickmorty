//
//  FavoritesViewController.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: Properties
    
    var viewModel: FavoritesViewModelType! = FavoritesViewModel()
    
    let apiService = ApiService()
    private let databaseManager = DatabaseManager.shared
    
    //MARK: UI Elements
    
    var headerView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(font: .proximaNovaSemibold(size: 28), textColor: .black)
        label.text = "Favorites"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset.bottom = 80
        tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyListView: EmptyListView = {
        let view = EmptyListView(title: "No favorites yet", subtitle: "Add some in the characters tab")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("noInternet"), object: nil, queue: nil) { [weak self] _ in
            self?.showDefaultAlert(with: "No Internet Connection")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        fetchData()
    }
    
    //MARK: - Database
    
    func fetchData() {
        databaseManager.fetchCharacters { [weak self] (complete, charactersArray) in
            guard let `self` = self, let characters = charactersArray, complete else {
                self?.emptyListView.isHidden = false
                return
            }
            self.emptyListView.isHidden = !characters.isEmpty
            self.viewModel.savedCharacters = characters
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
        view.addSubviews([headerView, emptyListView, tableView])
        headerView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(viewModel.headerHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyListView.snp.makeConstraints { make in
            make.centerX.equalTo(tableView)
            make.centerY.equalTo(tableView).multipliedBy(0.8)
        }
    }
    
}
