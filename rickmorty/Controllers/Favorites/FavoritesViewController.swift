//
//  FavoritesViewController.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    //MARK: Properties
    
    let viewModel = FavoritesViewModel()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("noInternet"), object: nil, queue: nil) { [weak self] _ in
            self?.showDefaultAlert(with: "No Internet Connection")
        }
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("noInternet"), object: nil)
    }
    
    //MARK: - Database
    
    func fetchData() {
        viewModel.fetchData { [weak self] (arrayIsEmpty) in
            self?.emptyListView.isHidden = !arrayIsEmpty
            self?.tableView.reloadData()
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
