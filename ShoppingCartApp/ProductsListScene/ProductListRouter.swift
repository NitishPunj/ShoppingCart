//
//  ProductListRouter.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 09/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

protocol ProductListRouterProtocol {
    func openWishList()
    func goToCheckOut()
}

class ProductListRouter {
    
    private weak var viewController: UIViewController?
    static func buildController(service: ShoppingCartServiceProtocol) -> ProductsViewController {
        
        guard let controller: ProductsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProductsViewController") as? ProductsViewController else { fatalError() }
        
        controller.presenter = {
            let presenter = ProductListPresenter()
            presenter.view = controller

            let interactor = ProductListInteractor(service: service)
            presenter.interactor = interactor
            let router = ProductListRouter()
            router.viewController = controller
            presenter.router = router
            return presenter
        }()
        
        return controller
    }
}

extension ProductListRouter: ProductListRouterProtocol {
    func openWishList() {
        //TODO:
    }
    
    func goToCheckOut() {
        //TODO:
    }
}

