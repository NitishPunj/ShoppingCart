//
//  ProductListInteractor.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 09/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol ProductListInteractorProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], APIError>) -> Void)
    func addToCart(productId: Int, completion: @escaping  (APIError?) -> Void)
    func addToWishlist(product: Product)
}


class ProductListInteractor {
    
    private let service: ShoppingCartServiceProtocol
    private let store: DataStoreProtocol
    
    init(service: ShoppingCartServiceProtocol, store: DataStoreProtocol) {
        self.service = service
        self.store = store
    }
}

extension ProductListInteractor: ProductListInteractorProtocol {
    
    func fetchProducts(completion: @escaping (Result<[Product], APIError>) -> Void) {
        service.getProducts { result in
            switch result {
            case.success(let products):
                completion(.success(products))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addToCart(productId: Int, completion: @escaping  (APIError?) -> Void) {
        service.addProduct(productId) { result in
            switch result {
            case.success():
                completion(nil)
            case.failure(let error):
                completion((error))
            }
        }
    }
    
    func addToWishlist(product: Product) {
        store.addToWishlist(product)
    }
}

