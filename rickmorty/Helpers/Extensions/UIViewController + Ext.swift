//
//  UIViewController + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 16/2/23.
//

import UIKit

extension UIViewController {
    var floatingTabBarController: TabBarController? {
        return tabBarController as? TabBarController
    }
    
    func showDefaultAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
