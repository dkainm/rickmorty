//
//  RickMortyTabBarController.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import UIKit
import SnapKit

class RickMortyTabBarController: UITabBarController {
    
    var offset: CGFloat = -6.5
    var isBottom: Bool = false
    
    private func setOffsets() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                print("iPhone X/XS/11 Pro")
                offset = -23
                isBottom = true
            case 2688:
                print("iPhone XS Max/11 Pro Max")
                offset = -21
                isBottom = true
            case 1792:
                print("iPhone XR/ 11 ")
                offset = -22
                isBottom = true
            default:
                print("Unknown")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let window = UIApplication.shared.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: bottomPadding - 5 /*offset*/, width: 182, height: 62), cornerRadius: (tabBar.frame.width/2)).cgPath
        
        layer.shadowColor = UIColor.placeholder.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.15
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        
        tabBar.layer.insertSublayer(layer, at: 1)
        
        tabBar.tintColor = .main
        tabBar.unselectedItemTintColor = .unselected
        
        tabBar.items?.forEach({ item in
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomPadding, right: 0)
        })
        
//        if let items = tabBar.items {
//            items.forEach { item in
//                if isBottom {
//                    // > iPhoneX
//                    item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -25, right: 0)
//                } else {
//                    // < iPhoneX
//                    item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0)
//                }
//
//            }
//        }
//
        tabBar.itemWidth = 40.0
        tabBar.itemPositioning = .centered
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setOffsets()
        
        let newTabBarHeight: CGFloat = 62
        let newTabBarWidth: CGFloat = 182//view.frame.width - 60
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.size.width = newTabBarWidth
        newFrame.origin.y = (view.frame.size.height - newTabBarHeight) - 30
        newFrame.origin.x = (view.frame.width - newTabBarWidth) / 2
        
        tabBar.frame = newFrame
    }
}
