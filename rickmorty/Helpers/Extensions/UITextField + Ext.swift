//
//  UITextField + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 11/2/23.
//

import UIKit

extension UITextField {
    func setLeftImage(_ image: UIImage?) {
        let iconView = UIImageView(frame: CGRect(x: 12, y: 12, width: 24, height: 24))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 48))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
