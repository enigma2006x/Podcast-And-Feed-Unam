//
//  ItemViewController.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import FeedKit
import Kingfisher
import AVKit

final class ItemViewController: UIViewController {
    
    var podcast: Podcast?
    var currentIndex: Int = 0
    var feed: Feed?
    
    private var totalItems: Int = 0
    
    private var item: RSSFeedItem?
    private let player : AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    @IBOutlet weak var durationLabel: UILabel?
    @IBOutlet weak var itemLabel: UILabel?
    @IBOutlet weak var itemImageView: UIImageView?
    @IBOutlet weak var playButton: UIButton?
    @IBOutlet weak var previousButton: UIButton?
    @IBOutlet weak var nextButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = podcast?.artistName
        
        updateItemData()
    }
    
    @IBAction func playAudio(_ sender: UIButton) {
        
        if player.timeControlStatus != .playing {
            guard let source = item?.enclosure?.attributes?.url,
                let url = URL(string: source) else {return}
            
            let playerItem = AVPlayerItem(url: url)
            
            player.replaceCurrentItem(with: playerItem)
            playAction()
            
        } else {
            pauseAction()
        }
    }
    
    @IBAction func previousAudio(_ sender: UIButton) {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = totalItems - 1
        }
        updateItemData()
    }
    
    @IBAction func nextAudio(_ sender: UIButton) {
        currentIndex += 1
        if currentIndex >= totalItems {
            currentIndex = 0
        }
        updateItemData()
    }
    
    private func updateItemData() {
        guard let items = feed?.rssFeed?.items else {
            return
        }
        pauseAction()
        item = items[currentIndex]
        totalItems = items.count
        itemLabel?.text = (item?.author ?? "") + " " + (item?.title ?? "")
        durationLabel?.text = getFormatTime(item?.iTunes?.iTunesDuration ?? 0)
        
        if let imageUrl = item?.iTunes?.iTunesImage?.attributes?.href, let url = URL(string: imageUrl)  {
            itemImageView?.kf.setImage(with: ImageResource(downloadURL: url))
        } else if let imageUrl = podcast?.artworkUrl100, let url = URL(string: imageUrl)  {
            itemImageView?.kf.setImage(with: ImageResource(downloadURL: url))
        }
    }
    
    private func getFormatTime(_ interval: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full

        return formatter.string(from: TimeInterval(interval)) ?? ""
    }
    
    private func playAction() {
        player.play()
        playButton?.setImage(UIImage(named: "pause"), for: .normal)
        playButton?.setImage(UIImage(named: "pause-filled"), for: .highlighted)
    }
    
    private func pauseAction() {
        player.pause()
        playButton?.setImage(UIImage(named: "play"), for: .normal)
        playButton?.setImage(UIImage(named: "play-filled"), for: .highlighted)
    }
    
}
