//
//  DataStore.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 10/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {
    
    func fetchWishlist() -> [ProductViewModel]
    func addToWishlist(_ product: ProductViewModel)
    func removeFromWishlist(_ product: ProductViewModel)
    func deleteAll()
}

protocol ProductViewModel {
    var name:String { get }
    var id: Int { get }
    var price: String { get }
}

