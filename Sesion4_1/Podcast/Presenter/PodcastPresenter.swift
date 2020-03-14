//
//  TrackPresenter.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import Foundation

final class TrackPresenter {
    
    private weak var delegate: TrackDelegate?
    private let client = TunesClient(configuration: .default)
    
    private var searchTask: DispatchWorkItem?
    
    init(delegate: TrackDelegate) {
        self.delegate = delegate
    }
    
    func getPodcasts(query: String) {
        // Cancel previous task if any
        self.searchTask?.cancel()
        
        // Replace previous task with a new one
        let task = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.delegate?.startLoading()
            self.client.getPodcasts(query: query) { [weak self] (result) in
                guard let self = self else { return }
                self.delegate?.endLoading()
                self.delegate?.getPodcasts(result: result)
            }
        }
        self.searchTask = task
        
        // Execute task in 0.75 seconds (if not cancelled !)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
}
