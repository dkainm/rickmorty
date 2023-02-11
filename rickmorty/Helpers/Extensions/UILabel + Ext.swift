//
//  UILabel + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import UIKit

extension UILabel {
    
    convenience init(font: UIFont?, textColor: UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
    
}

