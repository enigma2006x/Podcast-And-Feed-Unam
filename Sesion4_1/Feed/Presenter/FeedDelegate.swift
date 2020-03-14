//
//  FeedDelegate.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation
import FeedKit

protocol FeedDelegate: class {
    func startLoading()
    func endLoading()
    func getFeed(result: Result<Feed, ParserError>)
}
