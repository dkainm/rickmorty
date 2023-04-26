//
//  CharactersViewController.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import UIKit
import SnapKit

final class CharactersViewController: UIViewController {
    
    //MARK: Properties
    
    let viewModel = CharactersViewModel()
    
    //MARK: UI Elements
    
    var headerViewHeightAnchor: NSLayoutConstraint?
    lazy var cancelButtonWidthAnchor = cancelButton.widthAnchor.constraint(equalToConstant: 0)
    
    var headerView = UIView()
    
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
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.dark, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
        button.titleLabel?.font = .proximaNovaSemibold(size: 16)
        button.addTarget(self, action: #selector(cancelSearch), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var searchStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchBar, cancelButton])
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        tableView.register(PaginationViewCell.self, forCellReuseIdentifier: PaginationViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("noInternet"), object: nil, queue: nil) { [weak self] _ in
            self?.showDefaultAlert(with: "No Internet Connection")
        }
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("noInternet"), object: nil)
    }
    
    //MARK: - API
    
    func fetchData(page: Int? = nil) {
        viewModel.fetchData(page: page) { [weak self] in
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
        view.addSubviews([headerView, searchStackView, tableView])
        headerView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        searchStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        headerViewHeightAnchor = headerView.heightAnchor.constraint(equalToConstant: viewModel.headerHeight)
        
        headerViewHeightAnchor?.isActive = true
        cancelButtonWidthAnchor.isActive = true
    }
    
    func openHeader() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
            self.headerViewHeightAnchor?.constant = self.viewModel.headerHeight
            self.headerView.isHidden = false
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.floatingTabBarController?.tabBarIsHidden = false
            self.cancelButtonWidthAnchor.isActive = true
        })
    }
    
    func hideHeader() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
            self.headerViewHeightAnchor?.constant -= 36
            self.headerView.isHidden = true
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.floatingTabBarController?.tabBarIsHidden = true
            self.cancelButtonWidthAnchor.isActive = false
        })
    }
    
    //MARK: - Selectors
    
    @objc private func cancelSearch() {
        viewModel.isFilteringMode = false
        viewModel.searchParameters.name = nil
        fetchData()
        
        openHeader()
        searchBar.clearText()
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            tableView.contentInset.bottom = keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset.bottom = 110
    }
}
