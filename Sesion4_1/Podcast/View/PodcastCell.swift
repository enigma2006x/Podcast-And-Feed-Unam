//
//  PodcastCell.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 29/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import Kingfisher

final class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var podcastImageView: UIImageView?
    @IBOutlet weak var genresLabel: UILabel?
    
    var podcast: Podcast? {
        didSet{
            
            guard let podcast = podcast else { return }
            titleLabel?.text = podcast.artistName
            genresLabel?.text = podcast.getGenres()
            
            guard let imageUrl = podcast.artworkUrl60, let url = URL(string: imageUrl) else {return}
            podcastImageView?.kf.setImage(with: ImageResource(downloadURL: url))
        }
    }
}

extension PodcastCell: NibReusable {}
