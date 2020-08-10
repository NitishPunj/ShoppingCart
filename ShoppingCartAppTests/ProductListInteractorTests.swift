//
//  ProductListInteractorTests.swift
//  ShoppingCartAppTests
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import XCTest
@testable import ShoppingCartApp

class ProductListInteractorTests: XCTestCase {
    
    private var service: MockService!
    private var sut: ProductListInteractor!
    
    override func setUp() {
        super.setUp()
        service = MockService()
        sut = ProductListInteractor(service: service, store: MockStore())
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_fetchProducts() {
        
        service.throwError = false
        sut.fetchProducts { result in
            switch result {
            case.success(let products):
                XCTAssertEqual(products.count, 0)
            case .failure(_):
                XCTFail("We expect success")
            }
        }
    }
    
    func test_addToCart() {
        service.throwError = false
        sut.addToCart(productId: 2) { error in
            XCTAssertNil(error)
        }
    }
}

private class MockService: ShoppingCartServiceProtocol {
    
    var throwError = false
    func getProducts(completion: @escaping (Result<[Product], APIError>) -> Void) {
        throwError ? completion(.failure(APIError.noData)) : completion(.success([]))
    }
    
    func getCart(completion: @escaping (Result<[CartItem], APIError>) -> Void) {
    }
    
    func removeProduct(_ id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
    }
    
    func addProduct(_ productId: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        throwError ? completion(.failure(APIError.noData)) : completion(.success(()))
    }
}

private class MockStore: DataStoreProtocol {
    func fetchWishlist() -> [ProductViewModel] {
        return []
    }
    
    func addToWishlist(_ product: ProductViewModel) {
    }
    
    func removeFromWishlist(_ product: ProductViewModel) {
    }
    
    func deleteAll() {
    }
}
