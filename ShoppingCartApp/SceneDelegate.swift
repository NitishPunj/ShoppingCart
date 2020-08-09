//
//  SceneDelegate.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 07/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = window else { return }
        let navigationController = window.rootViewController as! UINavigationController
        var vc: ProductsViewController {
            return ProductListRouter.buildController(service: ShoppingCartService())
        }
        navigationController.setViewControllers([vc], animated: true)
    }
}

