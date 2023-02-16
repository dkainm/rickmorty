//
//  CharacterCardViewController.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import UIKit
import Nuke

class CharacterCardViewController: UIViewController {
    
    //MARK: Properties
    
    var character: Character! {
        didSet { configureContent() }
    }
    
    //MARK: UI Elements
    
    private var headerView = UIView()
    
    private var titleLabel = UILabel(font: .proximaNovaRegular(size: 16), textColor: .black)
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chevron.left"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [backImageView, titleLabel])
        stack.alignment = .center
        stack.spacing = 8
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissal)))
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 18
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(font: .proximaNovaBold(size: 20), textColor: .black)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "star.outline"), for: .normal)
        
        //TODO: !!!
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(changeFavoriteState), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel(font: .proximaNovaBold(size: 16), textColor: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var speciesLabel: UILabel = {
        let label = UILabel(font: .proximaNovaBold(size: 16), textColor: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var typeLabel: UILabel = {
        let label = UILabel(font: .proximaNovaBold(size: 16), textColor: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var genderLabel: UILabel = {
        let label = UILabel(font: .proximaNovaBold(size: 16), textColor: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var originLabel: UILabel = {
        let label = UILabel(font: .proximaNovaBold(size: 16), textColor: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var locationLabel: UILabel = {
        let label = UILabel(font: .proximaNovaBold(size: 16), textColor: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var statusTitleLabel = UILabel(font: .proximaNovaRegular(size: 14), textColor: .placeholder)
    private var speciesTitleLabel = UILabel(font: .proximaNovaRegular(size: 14), textColor: .placeholder)
    private var typeTitleLabel = UILabel(font: .proximaNovaRegular(size: 14), textColor: .placeholder)
    private var genderTitleLabel = UILabel(font: .proximaNovaRegular(size: 14), textColor: .placeholder)
    private var originTitleLabel = UILabel(font: .proximaNovaRegular(size: 14), textColor: .placeholder)
    private var locationTitleLabel = UILabel(font: .proximaNovaRegular(size: 14), textColor: .placeholder)
    
    private lazy var stackView: UIStackView = {
        let nameTitleLabel = UILabel(font: .proximaNovaRegular(size: 16), textColor: .placeholder)
        nameTitleLabel.text = "Name"
        
        let nameStack = UIStackView(arrangedSubviews: [nameTitleLabel, nameLabel])
        nameStack.axis = .vertical
        nameStack.spacing = 16
        nameStack.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        nameStack.isLayoutMarginsRelativeArrangement = true
        
        let topLeadingStack = UIStackView(arrangedSubviews: [avatarImageView, nameStack])
        topLeadingStack.alignment = .top
        topLeadingStack.spacing = 16
        
        let topStack = UIStackView(arrangedSubviews: [topLeadingStack, favoriteButton])
        topStack.distribution = .equalSpacing
        topStack.alignment = .top
        
        statusTitleLabel.text = "Status"
        speciesTitleLabel.text = "Species"
        typeTitleLabel.text = "Type"
        genderTitleLabel.text = "Gender"
        originTitleLabel.text = "Origin"
        locationTitleLabel.text = "Location"
        
        let statusStack = UIStackView(arrangedSubviews: [statusTitleLabel, statusLabel])
        let speciesStack = UIStackView(arrangedSubviews: [speciesTitleLabel, speciesLabel])
        let typeStack = UIStackView(arrangedSubviews: [typeTitleLabel, typeLabel])
        let genderStack = UIStackView(arrangedSubviews: [genderTitleLabel, genderLabel])
        let originStack = UIStackView(arrangedSubviews: [originTitleLabel, originLabel])
        let locationStack = UIStackView(arrangedSubviews: [locationTitleLabel, locationLabel])
        
        let settingsStack = UIStackView(arrangedSubviews: [statusStack, speciesStack, genderStack, originStack, locationStack])
        settingsStack.axis = .vertical
        settingsStack.spacing = 24
        settingsStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 32)
        settingsStack.isLayoutMarginsRelativeArrangement = true
        
        let stack = UIStackView(arrangedSubviews: [topStack, settingsStack])
        stack.axis = .vertical
        stack.spacing = 16
        stack.addVerticalSeparators(color: .divider)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingTabBarController?.tabBarIsHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        floatingTabBarController?.tabBarIsHidden = false
    }
    
    //MARK: - UI Methods
    
    private func configureUI() {
        view.backgroundColor = .background
        
        buildHierarchy()
        configureConstraints()
    }
    
    private func buildHierarchy() {
        view.addSubviews([headerView, cardView])
        headerView.addSubview(backStackView)
        cardView.addSubview(stackView)
    }
    
    private func configureConstraints() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(53 + topPadding)
        }
        
        backStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        backImageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(22)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(140)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.height.width.equalTo(28)
        }
        
        statusTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
        }
        
        speciesTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
        }
        
        typeTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
        }
        
        genderTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
        }
        
        originTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
        }
        
        locationTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
        }
    }
    
    //MARK: Helpers
    
    private func configureContent() {
        Nuke.loadImage(with: character.image, into: avatarImageView)
        
        titleLabel.text = character.name
        nameLabel.text = character.name
        
        statusLabel.text = character.status
        speciesLabel.text = character.species
        typeLabel.text = character.type ?? "-"
        genderLabel.text = character.gender
        originLabel.text = character.origin.name
        locationLabel.text = character.location.name
    }
    
    //MARK: Selectors
    
    @objc private func changeFavoriteState() {
        print(#function)
    }
    
    @objc private func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
    
}

