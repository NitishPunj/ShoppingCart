//
//  ShoppingCartEndpoints.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 08/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var method: HTTPMethod { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum ShoppingCartEndpoints {
    
    case getProdutcs
    case getCart
    case addproduct(productId: String)
    case removeProduct(cartItemId: String)
    
    private var queryItem: URLQueryItem? {
        switch self {
        case .addproduct(let productId):
            return URLQueryItem(name: "productId", value: productId)
        case .getProdutcs:
            return nil
        case .getCart:
            return nil
        case .removeProduct(let cartItemId):
            return URLQueryItem(name: "id", value: cartItemId)
        }
    }
    
    private var path: String {
        switch self {
        case .addproduct, .getCart, .removeProduct:
            return "/cloths/cart"
        case .getProdutcs:
            return "/cloths/products"
        }
    }
}

extension ShoppingCartEndpoints: Endpoint {
    
    var url: URL? {
        var urlComps = URLComponents()
        urlComps.scheme = "https"
        urlComps.host = "2klqdzs603.execute-api.eu-west-2.amazonaws.com"
        urlComps.path = path
        if let queryItem = queryItem {
            urlComps.queryItems = [queryItem]
        }
        return urlComps.url
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCart, .getProdutcs:
            return .get
        case .addproduct:
            return .post
        case .removeProduct:
            return .delete
        }
    }
}

