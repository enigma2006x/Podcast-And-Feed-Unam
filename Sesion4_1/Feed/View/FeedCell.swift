//
//  PodcastCell.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 29/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import FeedKit
import Kingfisher

typealias FeedData = (parent: Podcast?, item: RSSFeedItem?)

final class FeedCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var feedImageView: UIImageView?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    var value: FeedData? {
        didSet {
            guard let value = value,
                let parent = value.parent,
                let item = value.item else { return }
            
            titleLabel?.text = item.title
            if let description = item.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil), !description.isEmpty {
                descriptionLabel?.text = description
            } else {
                descriptionLabel?.text = item.iTunes?.iTunesAuthor
            }
            
            if let imageUrl = item.iTunes?.iTunesImage?.attributes?.href, let url = URL(string: imageUrl) {
                feedImageView?.kf.setImage(with: ImageResource(downloadURL: url))
            } else if let imageUrl = parent.artworkUrl100, let url = URL(string: imageUrl) {
                feedImageView?.kf.setImage(with: ImageResource(downloadURL: url))
            }
        }
    }
}

extension FeedCell: NibReusable {}
