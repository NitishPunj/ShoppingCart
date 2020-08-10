//
//  ProductListPresenterTests.swift
//  ShoppingCartAppTests
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import XCTest
@testable import ShoppingCartApp

class ProductListPresenterTests: XCTestCase {
    private var sut: ProductListPresenter!
    private var view: MockView!
    private var router: MockRouter!
    private var interactor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        
        view = MockView()
        sut = ProductListPresenter()
        sut.view = view
        router = MockRouter()
        sut.router = router
        interactor = MockInteractor()
        sut.interactor = interactor
    }
    
    override func tearDown() {
        
        view = nil
        sut = nil
        router = nil
        interactor = nil
        super.tearDown()
    }
    
    func test_viewIsReady_Success() {
        
        // InitialStage
        XCTAssertFalse(view.showLoadingDidCall)
        XCTAssertFalse(interactor.fetchProductsDidCall)
        
        // Action
        interactor.throwError = false
        sut.viewIsReady()
        
        // Result
        XCTAssertTrue(view.showLoadingDidCall)
        XCTAssertTrue(interactor.fetchProductsDidCall)
        
        // InitialStage before  async call
        XCTAssertFalse(view.hideLoadingDidCall)
        XCTAssertFalse(view.updateViewStateDidCall)
        
        waitFor { expectation in
            DispatchQueue.main.async {
                
                // Result
                XCTAssertTrue(self.view.hideLoadingDidCall)
                XCTAssertTrue(self.view.updateViewStateDidCall)
                XCTAssertEqual(self.sut.numberOfItems, 2)
                expectation.fulfill()
            }
        }
    }
    func test_viewIsReady_Failure() {
        
        // InitialStage
        XCTAssertFalse(view.showLoadingDidCall)
        XCTAssertFalse(interactor.fetchProductsDidCall)
        
        // Action
        interactor.throwError = true
        sut.viewIsReady()
        
        // Result
        XCTAssertTrue(view.showLoadingDidCall)
        XCTAssertTrue(interactor.fetchProductsDidCall)
        
        // InitialStage before  async call
        XCTAssertFalse(view.hideLoadingDidCall)
        XCTAssertFalse(view.updateViewStateDidCall)
        XCTAssertFalse(view.presentErrorDidCall)
        
        waitFor { expectation in
            DispatchQueue.main.async {
                
                // Result
                XCTAssertTrue(self.view.hideLoadingDidCall)
                XCTAssertTrue(self.view.updateViewStateDidCall)
                XCTAssertTrue(self.view.presentErrorDidCall)
                expectation.fulfill()
            }
        }
    }
    
    func test_addToCart_Success() {
        
        // InitialStage
        XCTAssertFalse(view.showLoadingDidCall)
        XCTAssertFalse(interactor.addToCartsDidCall)
        
        // Action
        interactor.throwError = false
        sut.productModels = products

        sut.addToCartPressedForItem(atIndexPath: IndexPath(row: 1, section: 0))
        XCTAssertFalse(view.hideLoadingDidCall)
        
        waitFor { expectation in
            DispatchQueue.main.async {
                
                // Result
                XCTAssertFalse(self.view.presentErrorDidCall)
                XCTAssertTrue(self.view.hideLoadingDidCall)
                expectation.fulfill()
            }
        }
    }
    
    func test_basketPressed() {
        XCTAssertFalse(router.goToCheckOutDidCall)
        sut.basketPressed()
        XCTAssertTrue(router.goToCheckOutDidCall)
    }
    
    func test_wishListPressed() {
        XCTAssertFalse(router.openWishListdidCall)
        sut.wishListPressed()
        XCTAssertTrue(router.openWishListdidCall)
    }
    
    func test_addToWishlist() {
        XCTAssertFalse(interactor.addToWishListDidCall)
        sut.productModels = products
        sut.addToWishlistPressedForItem(atIndexPath: IndexPath(row: 1, section: 0))
        XCTAssertTrue(interactor.addToWishListDidCall)
    }
    
}

private class MockRouter: ProductListRouterProtocol {
    var openWishListdidCall = false
    func openWishlist() {
        openWishListdidCall = true
    }
    
    var goToCheckOutDidCall = false
    func goToCheckOut(_ products: [Product]) {
        goToCheckOutDidCall = true
    }
}

private class MockView: ProductListViewProtocol {
    var showLoadingDidCall = false
    func showLoading() {
        showLoadingDidCall = true
    }
    var hideLoadingDidCall = false
    func hideLoading() {
        hideLoadingDidCall = true
    }
    
    var presentErrorDidCall = false
    func presentError(_ error: APIError) {
        presentErrorDidCall = true
    }
    var updateViewStateDidCall = false
    func updateViewState(_ state: ProductsViewState) {
        updateViewStateDidCall = true
    }
}

private class MockInteractor: ProductListInteractorProtocol {
    var addToWishListDidCall = false
    func addToWishlist(product: Product) {
        addToWishListDidCall = true
    }
    
    var result: Result<[Product], APIError>?
    var throwError = false
    
    var fetchProductsDidCall = false
    func fetchProducts(completion: @escaping (Result<[Product], APIError>) -> Void) {
        fetchProductsDidCall = true
        throwError ? completion(.failure(APIError.noData)) : completion(.success(products))
        
    }
    
    var addToCartsDidCall = false
    func addToCart(productId: Int, completion: @escaping (APIError?) -> Void) {
        addToCartsDidCall = true
        throwError ? completion(APIError.noData) : completion(nil)
    }
}

private let products: [Product] = [Product(id: 1, name: "Shoes", category: .womensFootwear, price: "33", oldPrice: "44", stock: 7),
                                   Product(id: 1, name: "Shoes", category: .womensFootwear, price: "33", oldPrice: "44", stock: 7)]


extension XCTestCase {
    
    func waitFor(_ action: (XCTestExpectation) -> Void) {
        let expectation = XCTestExpectation(description: "Perform task")
        action(expectation)
        wait(for: [expectation], timeout: 0.5)
    }
}
