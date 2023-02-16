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
}
