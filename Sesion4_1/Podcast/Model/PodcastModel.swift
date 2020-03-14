//
//  Model.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 29/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit

struct PodcastSearch: Codable {
    let resultCount: Int
    let results: [Podcast]
}

struct Podcast: Codable {
    let wrapperType: String
    let kind: String
    let artistName: String
    let trackId: Int
    let feedUrl: String
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let genres: [String]
    
    func getGenres() -> String {
        return genres.joined(separator: " / ")
    }
}
