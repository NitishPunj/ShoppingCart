//
//  WishlistInteractor.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol WishlistInteractorProtocol {
    func fetchProducts() -> [ProductViewModel]
    func removeFromWishlist(product: ProductViewModel)
}

class WishlistInteractor {
    
    private let service: ShoppingCartServiceProtocol
    private let store: DataStoreProtocol
    
    init(service: ShoppingCartServiceProtocol, store: DataStoreProtocol = RealmDataStore.shared) {
        self.service = service
        self.store = store
    }
}

extension WishlistInteractor: WishlistInteractorProtocol {
    func fetchProducts() -> [ProductViewModel] {
        return store.fetchWishlist()
    }
    
    func removeFromWishlist(product: ProductViewModel) {
        store.removeFromWishlist(product)
    }
    
    
}
