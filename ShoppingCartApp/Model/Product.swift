//
//  Product.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 08/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let category: Category
    let price: Double
    let oldPrice: Double?
    let stock: Int
}

enum Category: String, Codable {
    case womensFootwear = "Women’s Footwear"
    case mensFootwear = "Men’s Footwear"
    case womensCasualwear = "Women’s Casualwear"
    case mensCasualwear = "Men’s Casualwear"
    case womensFormalwear = "Women’s Formalwear"
    case mensFormalwear = "Men’s Formalwear"
}

extension Product {
    var outOfStock: Bool {
        return stock < 1
    }
    var isOnSale: Bool {
        return oldPrice != nil
    }
}
