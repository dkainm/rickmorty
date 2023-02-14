//
//  UIStackView + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import UIKit

extension UIStackView {
    
    func addVerticalSeparators(color: UIColor) {
        var i = self.arrangedSubviews.count
        while i >= 0 {
            guard i-1 > 0 else { break }
            let separator = createSeparator(color: color, type: .vertical)
            insertArrangedSubview(separator, at: i-1)
            i -= 1
        }
    }
    
    func createSeparator(color: UIColor, type: NSLayoutConstraint.Axis) -> UIView {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        separator.backgroundColor = color
        return separator
    }
}
