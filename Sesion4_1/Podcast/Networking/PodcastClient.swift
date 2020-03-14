//
//  PodcastClient.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

private enum PodcastEndPointHeader: String {
    case key = "x-rapidapi-key"
    case host = "x-rapidapi-host"
}

struct PodcastEndPoint: Endpoint {
    var baseUrl = "https://itunes.apple.com/search"
    private let key = "f0afd5e6camshc074180dfe084e4p1afed8jsn42ab8ac44616"
    private let host = "deezerdevs-deezer.p.rapidapi.com"
    var query: String?
    
    var urlComponents: URLComponents? {
        var components = URLComponents(string: baseUrl)
        components?.queryItems = [URLQueryItem(name: "term", value: query), URLQueryItem(name: "media", value: "podcast")]
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}

final class TunesClient: GenericAPIClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getPodcasts(query: String, completion: @escaping (Result<PodcastSearch?, APIError>) -> ()) {
        let podcastEndPoint = PodcastEndPoint(query: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        guard let request = podcastEndPoint.request else {
            return
        }
        fetch(with: request,
              decode: { json -> PodcastSearch? in
            guard let results = json as? PodcastSearch else { return  nil }
            return results
        }, completion: completion)
    }
}
