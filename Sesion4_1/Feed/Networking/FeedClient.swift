//
//  FeedClient.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation
import FeedKit

struct FeedEndPoint: Endpoint {
    var baseUrl: String
   
    var urlComponents: URLComponents? {
        let components = URLComponents(string: baseUrl)
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}

final class FeedClient {
    func getFeed(_ urlFeed: String,
                 completionQueue: DispatchQueue = .main,
                 completion: @escaping (Result<Feed, ParserError>) -> Void) {
        let endpoint = FeedEndPoint(baseUrl: urlFeed)
        guard let url = endpoint.request?.url else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync(queue: completionQueue, result: completion)
    }
}
