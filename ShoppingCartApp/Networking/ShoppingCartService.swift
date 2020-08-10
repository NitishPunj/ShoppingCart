//
//  ShoppingCartService.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 08/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol ShoppingCartServiceProtocol {
    
    func getProducts(completion: @escaping (Result<[Product], APIError>) -> Void)
    func getCart(completion: @escaping (Result<[CartItem], APIError>) -> Void)
    func removeProduct(_ id: Int, completion: @escaping  (Result<Void, APIError>) -> Void)
    func addProduct(_ productId: Int, completion: @escaping  (Result<Void, APIError>) -> Void)
}


class ShoppingCartService: ShoppingCartServiceProtocol {
    
    private let dispatcher: Dispatcher
    private let decoder: JSONDecoder
    
    init(dispatcher: Dispatcher = NetworkDispatcher(), decoder: JSONDecoder = JSONDecoder()) {
        self.dispatcher = dispatcher
        self.decoder = decoder
    }
    
    func getProducts(completion: @escaping (Result<[Product], APIError>) -> Void) {
        guard let request = URLRequestComposer.buildRequestFor(ShoppingCartEndpoints.getProdutcs) else {
            completion(.failure(.badURL))
            return
        }
        
        dispatcher.execute(request: request) { result in
            switch result {
            case .success(let data):
                guard let unwrappedData = data else { completion(.failure(.noData))
                    return
                }
                do {
                    let products = try self.decoder.decode([Product].self, from: unwrappedData)
                    completion(.success(products))
                }
                catch let decodingError {
                    completion(.failure(.decoding(error: decodingError)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCart(completion: @escaping (Result<[CartItem], APIError>) -> Void) {
        guard let request = URLRequestComposer.buildRequestFor(ShoppingCartEndpoints.getCart) else {
            completion(.failure(.badURL))
            return
        }
        
        dispatcher.execute(request: request) { result in
            switch result {
            case .success(let data):
                guard let unwrappedData = data else { completion(.failure(.noData))
                    return
                }
                do {
                    let cartItems = try self.decoder.decode([CartItem].self, from: unwrappedData)
                    completion(.success(cartItems))
                }
                catch let decodingError {
                    completion(.failure(.decoding(error: decodingError)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func removeProduct(_ id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let request = URLRequestComposer.buildRequestFor(ShoppingCartEndpoints.removeProduct(cartItemId: id.description)) else {
            completion(.failure(.badURL))
            return
        }
        dispatcher.execute(request: request) { result in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addProduct(_ productId: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let request = URLRequestComposer.buildRequestFor(ShoppingCartEndpoints.addproduct(productId: productId.description)) else {
            completion(.failure(.badURL))
            return
        }
        dispatcher.execute(request: request) { result in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                
                switch error {
                case .statusCode(let code):
                    if code == 403 {
                        completion(.failure(.noMoreStock))
                    }
                default:
                    completion(.failure(error))
                }
                
            }
        }
    }
}
