//
//  RickMortySearchBar.swift
//  rickmorty
//
//  Created by Alex Rudoi on 11/2/23.
//

import UIKit

class RickMortySearchBar: UIView {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = .proximaNovaRegular(size: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - Properties
    
    var placeholder: String? {
        get {
            textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    var delegate: UITextFieldDelegate? {
        get {
            textField.delegate
        }
        set {
            textField.delegate = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType {
        get {
            textField.returnKeyType
        }
        set {
            textField.returnKeyType = newValue
        }
    }
    
    var enablesReturnKeyAutomatically: Bool {
        get {
            textField.enablesReturnKeyAutomatically
        }
        set {
            textField.enablesReturnKeyAutomatically = newValue
        }
    }
    
    var placeholderString: String = "" {
        didSet {
            textField.attributedPlaceholder = NSMutableAttributedString(string: placeholderString, attributes: [
                NSAttributedString.Key.kern: 0.1,
                NSAttributedString.Key.font: UIFont.proximaNovaRegular(size: 16),
                NSAttributedString.Key.foregroundColor: UIColor.placeholder
            ])
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK: - Helpers
    
    func commonInit() {
        addSubviews([textField])
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textField.semanticContentAttribute = .forceLeftToRight
        textField.textAlignment = .left
        textField.setLeftImage(UIImage(named: "search"))
        
        textField.textColor = .black
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 16
        textField.clipsToBounds = true
        textField.enablesReturnKeyAutomatically = true
        
        textField.addTarget(self, action: #selector(setField), for: .editingChanged)
//        textField.addTarget(self, action: #selector(activateField), for: .editingDidBegin)
    }
    
    @objc func setField() {
        guard textField.text == "" || textField.text == nil || textField.text == " " else { return }
        textField.setLeftImage(UIImage(named: "search"))
    }
}

