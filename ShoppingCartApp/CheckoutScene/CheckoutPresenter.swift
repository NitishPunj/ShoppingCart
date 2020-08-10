//
//  CheckoutPresenter.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol CheckoutPresenterProtocol : class {
    
    var numberOfItems: Int { get }
    var totalPrice: String { get }
    func viewIsReady()
    func objectAtIndexPath(_ indexPath: IndexPath) -> CartItemViewModel?
    func removeItem(atIndexPath indexPath: IndexPath)
}

class CheckoutPresenter {
    
    var router: CheckoutRouterProtocol?
    weak var view: CheckoutViewProtocol?
    var interactor: CheckoutInteractorProtocol?
    
    private var cartItemsViewModels: [CartItemViewModel] = []
    private let productsCache: [Product]
    
    
    init(productsCache: [Product]) {
        self.productsCache = productsCache
    }
    
    private func setupViewModels(cartItems: [CartItem]) {
        cartItemsViewModels = cartItems.map({ CartItemViewModel(id: $0.id, product: productWithId($0.productId)) })
    }
    
    private func  productWithId(_ productId: Int) -> Product? {
        return  productsCache.first(where: {$0.id == productId})
    }
}

extension CheckoutPresenter: CheckoutPresenterProtocol {
    
    var totalPrice: String {
        return cartItemsViewModels.map( {$0.priceValue} ).reduce(0, +).description
    }
    
    func objectAtIndexPath(_ indexPath: IndexPath) -> CartItemViewModel? {
        guard cartItemsViewModels.indices.contains(indexPath.row) else { return nil }
        return cartItemsViewModels[indexPath.row]
    }
    
    var numberOfItems: Int {
        cartItemsViewModels.count
    }
    
    func viewIsReady() {
        view?.showLoading()
        interactor?.fetchProducts { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case .success (let items):
                    self.setupViewModels(cartItems: items)
                    self.view?.updateViewState(.reload)
                    
                case .failure(let error):
                    print(error)
                    self.view?.updateViewState(.noData)
                    self.view?.presentError(error)
                }
            }
        }
    }
    
    func removeItem(atIndexPath indexPath: IndexPath) {
        guard cartItemsViewModels.indices.contains(indexPath.row) else { return }
        let id = cartItemsViewModels[indexPath.row].id
        view?.showLoading()
        interactor?.removeItemFromCart(id: id) { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                if let error = error {
                    self.view?.presentError(error)
                } else {
                    self.cartItemsViewModels.remove(at: indexPath.row)
                    self.view?.updateViewState(.reload)
                }
            }
        }
    }
}


struct CartItemViewModel {
    let id: Int
    let product: Product?
}

extension CartItemViewModel {
    var nameLabel: String {
        return product?.name ?? ""
    }
    var priceLabel: String {
        return product?.price ?? ""
    }
    var priceValue: Double {
        return Double(priceLabel) ?? 0
    }
    
}

