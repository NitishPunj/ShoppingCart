//
//  WishlistPresenter.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol WishlistPresenterProtocol : class {
    
    var numberOfItems: Int { get }
    func viewIsReady()
    func objectAtIndexPath(_ indexPath: IndexPath) -> ProductViewModel?
    func removeItem(atIndexPath indexPath: IndexPath)
}

class WishlistPresenter {
    
    var router: WishlistRouter?
    weak var view: WishlistViewProtocol?
    var interactor: WishlistInteractor?
    private var productViewModels: [ProductViewModel] = []
}

extension WishlistPresenter: WishlistPresenterProtocol {
    var numberOfItems: Int {
        return productViewModels.count
    }
    
    func viewIsReady() {
        productViewModels = interactor?.fetchProducts() ?? []
    }
    
    func objectAtIndexPath(_ indexPath: IndexPath) -> ProductViewModel? {
        guard productViewModels.indices.contains(indexPath.row) else { return nil }
        return productViewModels[indexPath.row]
    }
    
    func removeItem(atIndexPath indexPath: IndexPath) {
        interactor?.removeFromWishlist(product: productViewModels[indexPath.row])
        productViewModels.remove(at: indexPath.row)
        view?.reloadTable()
        
    }
}
