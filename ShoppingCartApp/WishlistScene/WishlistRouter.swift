//
//  WishlistRouter.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

class WishlistRouter {
    
    private weak var viewController: UIViewController?
    static func buildController(service: ShoppingCartServiceProtocol) -> WishlistViewController {
        
        guard let controller: WishlistViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WishlistViewController") as? WishlistViewController else { fatalError() }
        
        controller.presenter = {
            let presenter = WishlistPresenter()
            presenter.view = controller

            let interactor = WishlistInteractor(service: service)
            presenter.interactor = interactor
            let router = WishlistRouter()
            router.viewController = controller
            presenter.router = router
            return presenter
        }()
        return controller
    }
}
