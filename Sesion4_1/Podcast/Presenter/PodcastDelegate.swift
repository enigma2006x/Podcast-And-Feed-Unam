//
//  TrackDelegate.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

protocol TrackDelegate: class {
    func startLoading()
    func endLoading()
    func getPodcasts(result: Result<PodcastSearch?, APIError>)
}

