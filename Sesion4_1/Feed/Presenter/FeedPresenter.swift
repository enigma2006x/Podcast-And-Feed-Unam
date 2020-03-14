//
//  FeedPresenter.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

final class FeedPresenter {
    
    private weak var delegate: FeedDelegate?
    private let client = FeedClient()
    
    init(delegate: FeedDelegate) {
        self.delegate = delegate
    }
    
    func getFeed(_ urlFeed: String) {
        delegate?.startLoading()
        client.getFeed(urlFeed) { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.endLoading()
            self.delegate?.getFeed(result: result)
        }
    }
}
