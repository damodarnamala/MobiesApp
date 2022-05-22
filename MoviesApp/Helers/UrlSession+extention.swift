//
//  UrlSession+extention.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    static var testError = "Testing error"
    case statusCode
    case decodeError
    case error(String)
}

extension URLSession {
    
    func get<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>  {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
