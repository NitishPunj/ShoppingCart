//
//  CheckoutInteractor.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol CheckoutInteractorProtocol {
    func fetchProducts(completion: @escaping (Result<[CartItem], APIError>) -> Void)
    func removeItemFromCart(id: Int, completion: @escaping  (APIError?) -> Void)
}

class CheckoutInteractor {
    
    private let service: ShoppingCartServiceProtocol
    
    init(service: ShoppingCartServiceProtocol) {
        self.service = service
    }
}

extension CheckoutInteractor: CheckoutInteractorProtocol {
    func fetchProducts(completion: @escaping (Result<[CartItem], APIError>) -> Void) {
        service.getCart { result in
            switch result {
            case.success(let items):
                completion(.success(items))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func removeItemFromCart(id: Int, completion: @escaping (APIError?) -> Void) {
        service.removeProduct(id) { result in
            switch result {
            case.success():
                completion(nil)
            case.failure(let error):
                completion((error))
            }
        }
    }
}


