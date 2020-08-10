//
//  ProductListRouterTests.swift
//  ShoppingCartAppTests
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import XCTest
@testable import ShoppingCartApp
class ProductListRouterTests: XCTestCase {
    
    func testBuildController() {
        let controller = ProductListRouter.buildController(service: ShoppingCartService())
        XCTAssertTrue(controller.isKind(of: ProductsViewController.self))
    }
}
