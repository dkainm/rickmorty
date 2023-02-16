//
//  FloatingBarView.swift
//  rickmorty
//
//  Created by Alex Rudoi on 15/2/23.
//

import UIKit

protocol FloatingBarViewDelegate: AnyObject {
    func didSelect(index: Int)
}

class FloatingBarView: UIView {

    weak var delegate: FloatingBarViewDelegate?

    var icons = [String]()
    var buttons: [UIButton] = []

    init(_ icons: [String]) {
        super.init(frame: .zero)
        self.icons = icons
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = bounds.height / 2
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        setupStackView(icons)
        update(selectedIndex: 0)
    }

    func setupStackView(_ items: [String]) {
        for (index, item) in items.enumerated() {
            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
            let normalImage = UIImage(named: item, in: nil, with: symbolConfig)
            let selectedImage = normalImage?.withTintColor(.main, renderingMode: .automatic)
            let button = createButton(normalImage: normalImage!, selectedImage: selectedImage!, index: index)
            buttons.append(button)
        }

        let stackView = UIStackView(arrangedSubviews: buttons)

        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
    }

    func createButton(normalImage: UIImage, selectedImage: UIImage, index: Int) -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.height.width.equalTo(60)
        }
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tag = index
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(changeTab(_:)), for: .touchUpInside)
        return button
    }

    @objc
    func changeTab(_ sender: UIButton) {
        sender.pulse()
        delegate?.didSelect(index: sender.tag)
        update(selectedIndex: sender.tag)
    }

    func update(selectedIndex: Int) {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.isSelected = true
                if index == 0 {
                    button.tintColor = .main
                } else {
                    button.tintColor = nil
                }
            } else {
                button.isSelected = false
                button.tintColor = nil
            }
        }
    }

    func toggle(hide: Bool) {
        if !hide {
            isHidden = hide
        }

        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = hide ? 0 : 1
            self.transform = hide ? CGAffineTransform(translationX: 0, y: 10) : .identity
        }) { (_) in
            if hide {
                self.isHidden = hide
            }
        }
    }
}

extension UIButton {

    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}

