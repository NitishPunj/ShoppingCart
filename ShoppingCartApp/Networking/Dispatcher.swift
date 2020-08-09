//
//  Dispatcher.swift
//  ShoppingCartApp
//
//  Created by N Sharma on 08/08/2020.
//  Copyright © 2020 SharmaNitish. All rights reserved.
//

import Foundation

protocol Dispatcher {
    func execute(request: URLRequest, completion: @escaping (Result<Data?, APIError>) -> Void)
}

class NetworkDispatcher: Dispatcher {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute(request: URLRequest, completion: @escaping (Result<Data?, APIError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(error: error)))
            }
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    completion(.success(data))
                default:
                    completion(.failure(.statusCode(code: response.statusCode)))
                }
            }
        }
        task.resume()
    }
}
