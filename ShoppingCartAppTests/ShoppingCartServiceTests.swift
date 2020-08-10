//
//  ShoppingCartServiceTests.swift
//  ShoppingCartAppTests
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import XCTest
@testable import ShoppingCartApp


class ShoppingCartServiceTests: XCTestCase {
    
    var sut: ShoppingCartService!
    
    
    func test_getProducts_Failure() {
        let dispatcher = MockDispatcher()
        dispatcher.throwError = true
        dispatcher.resultData = Data()
        sut = ShoppingCartService(dispatcher: MockDispatcher())
        
        sut.getProducts { result in
            switch result {
            case .success(_):
                XCTFail("We expect failure")
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        // No Data
        dispatcher.throwError = true
        dispatcher.resultData = Data()
        
        sut.getProducts { result in
            switch result {
            case .success(_):
                XCTFail("We expect failure")
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func test_getProducts_Success() {
        let dispatcher = MockDispatcher()
        dispatcher.throwError = false
        dispatcher.resultData = jsonProductsString.data(using: .utf8)!
        sut = ShoppingCartService(dispatcher: dispatcher)
        
        sut.getProducts { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(data.count, 2)
            case .failure(let error):
                print(error)
                XCTFail("We expect success")
            }
        }
    }
    
    
    func test_getCart_Failure() {
        let dispatcher = MockDispatcher()
        dispatcher.throwError = true
        dispatcher.resultData = Data()
        sut = ShoppingCartService(dispatcher: MockDispatcher())
        
        sut.getCart { result in
            switch result {
            case .success(_):
                XCTFail("We expect failure")
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        // No Data
        dispatcher.throwError = true
        dispatcher.resultData = Data()
        
        sut.getCart { result in
            switch result {
            case .success(_):
                XCTFail("We expect failure")
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func test_getCart_Success() {
        let dispatcher = MockDispatcher()
        dispatcher.throwError = false
        dispatcher.resultData = jsonCartItemString.data(using: .utf8)!
        sut = ShoppingCartService(dispatcher: dispatcher)
        
        sut.getCart { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(data.count, 5)
            case .failure(let error):
                print(error)
                XCTFail("We expect success")
            }
        }
    }
    
    
    
    func test_addProduct() {
        let dispatcher = MockDispatcher()
        dispatcher.throwError = true
        sut = ShoppingCartService(dispatcher: dispatcher)
        
        sut.addProduct(3) { result in
            switch result {
            case .success(_):
                XCTFail("We expect failure")
            case .failure(let error):
                XCTAssertNotNil(error)
                
            }
        }
    }
    
    func test_RemoveProduct() {
        let dispatcher = MockDispatcher()
        dispatcher.throwError = true
        sut = ShoppingCartService(dispatcher: dispatcher)
        
        sut.removeProduct(3) { result in
            switch result {
            case .success(_):
                XCTFail("We expect failure")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    
    private final class MockDispatcher: Dispatcher {
        var resultData: Data? = nil
        var throwError: Bool = false
        func execute(request: URLRequest, completion: @escaping (Result<Data?, APIError>) -> Void) {
            
            throwError ? completion(.failure(.network(error: APIError.noData))) : completion(.success(resultData))
        }
    }
    
    private let jsonProductsString = """
    [
    {
      "id": 1,
      "name": "Almond Toe Court Shoes, Patent Black",
      "category": "Women’s Footwear",
      "price": "99.00",
      "oldPrice": null,
      "stock": 4
    },
    {
      "id": 2,
      "name": "Suede Shoes, Blue",
      "category": "Women’s Footwear",
      "price": "42.00",
      "oldPrice": null,
      "stock": 4
    }]
    """
    private let jsonCartItemString = """
    [{
      "id": 2,
      "productId": 1
    },
    {
      "id": 3,
      "productId": 6
    },
    {
      "id": 8,
      "productId": 6
    },
    {
      "id": 12,
      "productId": 7
    },
    {
      "id": 11,
      "productId": 8
    }]
    """
}


