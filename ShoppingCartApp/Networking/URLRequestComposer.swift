//
//  URLRequestComposer.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 08/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

struct URLRequestComposer {
    
    static func buildRequestFor(_ endpoint: Endpoint, cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy)  -> URLRequest? {
        guard let url = endpoint.url else { return nil }
        var urlRequest =  URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 30)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue(AppConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
        return urlRequest
    }
}

