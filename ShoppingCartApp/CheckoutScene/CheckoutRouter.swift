//
//  CheckoutRouter.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import UIKit

protocol CheckoutRouterProtocol {}

class CheckoutRouter {
    
    private weak var viewController: UIViewController?
    static func buildController(service: ShoppingCartServiceProtocol, products: [Product]) -> CheckoutViewController {
        
        guard let controller: CheckoutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CheckoutViewController") as? CheckoutViewController else { fatalError() }
        
        controller.presenter = {
            let presenter = CheckoutPresenter(productsCache: products)
            presenter.view = controller

            let interactor = CheckoutInteractor(service: service)
            presenter.interactor = interactor
            let router = CheckoutRouter()
            router.viewController = controller
            presenter.router = router
            return presenter
        }()
        return controller
    }
}
extension CheckoutRouter: CheckoutRouterProtocol {
    
}
