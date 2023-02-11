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
        let label = UILabel(font: .proximaNovaSemibold(size: 24), textColor: .black)
        label.text = "Characters"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        apiService.fetchCharacters { (response) in
            guard let _ = response else {
                print("no characters")
                return
            }
        }
    }
    
    //MARK: - UI Methods
    
    private func configureUI() {
        view.backgroundColor = .background
        
        buildHierarchy()
        configureConstraints()
    }
    
    private func buildHierarchy() {
        view.addSubviews([headerView])
        headerView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53 + topPadding)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}
