//
//  RickMortyTabBarController.swift
//  rickmorty
//
//  Created by Alex Rudoi on 13/2/23.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    var tabBarIsHidden: Bool {
        set {
            floatingTabbarView.toggle(hide: newValue)
        }
        get {
            floatingTabbarView.isHidden
        }
    }
    
    private lazy var floatingTabbarView: FloatingBarView = {
        let view = FloatingBarView(["rick", "star"])
        view.tintColor = .main
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        tabBar.isHidden = true
        
        view.addSubview(floatingTabbarView)
        
        floatingTabbarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).inset(50)
        }
    }
    
}

extension TabBarController: FloatingBarViewDelegate {
    func didSelect(index: Int) {
        selectedIndex = index
    }
}
