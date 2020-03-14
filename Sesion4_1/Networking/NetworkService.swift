//
//  NetworkService.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse
}

protocol Endpoint {
    var baseUrl: String { get }
    var request: URLRequest?  { get }
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with endPoint: Endpoint,
                             completionQueue: DispatchQueue,
                             completion: @escaping (Result<T, NetworkError>) -> Void)
}
