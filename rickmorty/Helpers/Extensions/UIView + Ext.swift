//
//  UIView + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ self.addSubview($0) })
    }
}
    
