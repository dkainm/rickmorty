//
//  CharacterViewCell.swift
//  rickmorty
//
//  Created by Alex Rudoi on 11/2/23.
//

import UIKit
import Nuke

class CharacterViewCell: UITableViewCell {
    
    //MARK: Properties
    
    var character: Character!
    
    //MARK: UI Elements
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
    
    private var nameLabel = UILabel(font: .proximaNovaBold(size: 16), textColor: .black)
    private var statusLabel = UILabel(font: .proximaNovaRegular(size: 14), textColor: .placeholder)
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let textStack = UIStackView(arrangedSubviews: [nameLabel, statusLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let stack = UIStackView(arrangedSubviews: [avatarImageView, textStack, arrowImageView])
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 8
        container.layer.shadowColor = UIColor.placeholder.cgColor
        container.layer.shadowOpacity = 0.08
        container.layer.cornerRadius = 16
        container.layer.masksToBounds = false
    }
    
    //MARK: - Helpers
    
    func configure(with character: Character) {
        self.character = character
        
        nameLabel.text = character.name
        statusLabel.text = character.status.capitalized
        
        Nuke.loadImage(with: character.image, into: avatarImageView)
    }
    
    //MARK: - UI Methods
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        buildHierarchy()
        configureConstraints()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(container)
        container.addSubview(stackView)
    }
    
    private func configureConstraints() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(44)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
    }
}

