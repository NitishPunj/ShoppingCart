//
//  ProductListPresenter.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 09/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol ProductListPresenterProtocol : class {
    var numberOfItems: Int { get }
    func viewIsReady()
    func objectAtIndexPath(_ indexPath: IndexPath) -> Product?
    func addToWishlistPressedForItem(atIndexPath indexPath: IndexPath)
    func addToCartPressedForItem(atIndexPath indexPath: IndexPath)
    func basketPressed()
    func wishListPressed()
}

class ProductListPresenter {
    var router: ProductListRouterProtocol?
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorProtocol?
    var productModels: [Product] = []
}

extension ProductListPresenter: ProductListPresenterProtocol {
    
    var numberOfItems: Int {
        return productModels.count
    }
    
    func viewIsReady() {
        view?.showLoading()
        interactor?.fetchProducts { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case .success (let products):
                    self.productModels = products
                    self.view?.updateViewState(.reload)
                    
                case .failure(let error):
                    print(error)
                    self.view?.updateViewState(.noData)
                    self.view?.presentError(error)
                }
            }
        }
    }
    
    func objectAtIndexPath(_ indexPath: IndexPath) -> Product? {
        guard productModels.indices.contains(indexPath.row) else { return nil }
        return productModels[indexPath.row]
    }
    
    func addToWishlistPressedForItem(atIndexPath indexPath: IndexPath) {
        //TODO:
    }
    
    func addToCartPressedForItem(atIndexPath indexPath: IndexPath) {
        guard productModels.indices.contains(indexPath.row) else { return }
        let id = productModels[indexPath.row].id
        view?.showLoading()
        interactor?.addToCart(productId: id) { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                if let error = error {
                    self.view?.presentError(error)
                }
            }
        }
    }
    
    func basketPressed() {
        router?.goToCheckOut(productModels)
    }
    
    func wishListPressed() {
        router?.openWishlist()
    }
}

