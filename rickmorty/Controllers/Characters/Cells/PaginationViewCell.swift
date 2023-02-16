//
//  PaginationViewCell.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import UIKit

class PaginationViewCell: UITableViewCell {
    
    //MARK: Properties
    
    var pagination: Pagination!
    
    var isFilteringMode = false {
        didSet {
            container.backgroundColor = isFilteringMode ? .black.withAlphaComponent(0.05) : .white
        }
    }
    
    //MARK: UI Elements
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(font: .proximaNovaSemibold(size: 16), textColor: .placeholder)
        label.text = "Show more"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        container.layer.cornerRadius = 8
        container.layer.masksToBounds = false
    }
    
    //MARK: - Helpers
    
    func configure(with pagination: Pagination) {
        self.pagination = pagination
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
        container.addSubview(label)
    }
    
    private func configureConstraints() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
