//
//  SceneDelegate.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let charactersVC = UINavigationController(rootViewController: CharactersViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        
        let tabBarController = TabBarController()
        tabBarController.setViewControllers([charactersVC, favoritesVC], animated: true)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

