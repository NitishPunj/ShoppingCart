//
//  APIError.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 08/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURL
    case decoding(error: Error)
    case noData
    case network(error: Error)
    case statusCode(code: Int)
}
