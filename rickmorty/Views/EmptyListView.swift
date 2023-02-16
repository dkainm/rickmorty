//
//  EmptyListView.swift
//  rickmorty
//
//  Created by Alex Rudoi on 16/2/23.
//

import UIKit

class EmptyListView: UIView {
    
    private var titleLabel = UILabel(font: .proximaNovaBold(size: 24), textColor: .black)
    private var subtitleLabel = UILabel(font: .proximaNovaRegular(size: 18), textColor: .placeholder)
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubviews([titleLabel, subtitleLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
}
